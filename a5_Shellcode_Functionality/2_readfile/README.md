# 5.2 Payload *linux/x86/read_file*

### Check options
```
msfvenom -p linux/x86/read_file --list-options
```

![Screenshot](images/read_file/1.png)

![Screenshot](images/read_file/2.png)


There are 3 basic options:

- FD: The file descriptor to write output to (Required). Default: 1
- PATH: The file path to read (Required)


For this study we will use the basic options:

```bash
msfvenom -p linux/x86/read_file FD=1 PATH=/etc/passwd --platform=Linux -a x86 -f c
```


### One-liner for getting shellcode 

The fastest way to get the shellcode in my case was using two pipes, one with 'sed' and a second one with 'paste' command:

```bash
msfvenom -p linux/x86/read_file --platform=Linux -a x86 -f c FD=1 PATH=/etc/passwd | grep '"' | sed -e 's/\"//g' | paste -sd "" - | tr ";" " "
```

Using it, we get the shellcode we will use for the study of the payload:

![Screenshot](images/read_file/3.png)


### Libemu

Libemu does not show any output in this case:

![Screenshot](images/read_file/4.png)

When the PNG picture is generated it is empty.


### Ndisasm

With ndisasm it is possible to get the .nasm code using:

```bash
msfvenom -p linux/x86/read_file --platform=Linux -a x86 -f raw FD=1 PATH=/etc/passwd | ndisasm -u -
```


Or a little quicker:

```bash
echo -ne "\xeb\x36\xb8\x05\x00\x00\x00\x5b\x31\xc9\xcd\x80\x89\xc3\xb8\x03\x00\x00\x00\x89\xe7\x89\xf9\xba\x00\x10\x00\x00\xcd\x80\x89\xc2\xb8\x04\x00\x00\x00\xbb\x01\x00\x00\x00\xcd\x80\xb8\x01\x00\x00\x00\xbb\x00\x00\x00\x00\xcd\x80\xe8\xc5\xff\xff\xff\x2f\x65\x74\x63\x2f\x70\x61\x73\x73\x77\x64\x00" | ndisasm -u -
```


![Screenshot](images/read_file/5.png)

Using awk it is possible to get only the part we want and create a .nasm file:

```bash
echo -e "section .text\nglobal _start \n_start:" > 2.nasm

echo -ne "\xeb\x36\xb8\x05\x00\x00\x00\x5b\x31\xc9\xcd\x80\x89\xc3\xb8\x03\x00\x00\x00\x89\xe7\x89\xf9\xba\x00\x10\x00\x00\xcd\x80\x89\xc2\xb8\x04\x00\x00\x00\xbb\x01\x00\x00\x00\xcd\x80\xb8\x01\x00\x00\x00\xbb\x00\x00\x00\x00\xcd\x80\xe8\xc5\xff\xff\xff\x2f\x65\x74\x63\x2f\x70\x61\x73\x73\x77\x64\x00" | ndisasm -u - | awk '{$2=$2};1' - | cut -d " " -f 3-10 >> 2.nasm
```

![Screenshot](images/read_file/6.png)


With a little bit of indentation, the nasm file is created and ready to be studied. 


### Studying the syscalls

Given we have the nasm code, the first thing to do will be studying the different syscalls. We can do this checking the lines containing "int 0x80" in the code. 

In this case we have four syscalls:

![Screenshot](images/read_file/7.png)


After checking the */usr/include/i386-linux-gnu/asm/unistd_32.h* file, the syscalls seem to be:

- Syscall 1 (Value 0x5 or 5 in decimal): open() - *It opens the file specified by pathname*.

- Syscall 2 (Value 0x3 or 3 in decimal): read() - *It attempts  to  read up to count bytes from file descriptor fd into the buffer starting at buf.*

- Syscall 3 (Value 0x4 or 4 in decimal): write() - *It writes up to count bytes from the buffer pointed buf to the file referred to by the file descriptor fd.*

- Syscall 4 (Value 0x1 or 1 in decimal): exit() - *It causes normal process termination and the value of status & 0377 is returned to the parent*



### Generating the executable

Next, the executable gets generated using the *shellcode.c* script:

![Screenshot](images/read_file/8.png)

It is compiled:

```bash
gcc -fno-stack-protector -z execstack shellcode.c -o 2
```

An executable named "2" gets generated. It is possible to execute it and check the output:

![Screenshot](images/read_file/9.png)


Also note that if we study the binary there are interesting strings we can find (this one will appear again later):

![Screenshot](images/read_file/10.png)


### Study with GDB

First, the executable is attached in quiet mode:

```bash
gdb -q 2
```
Then, we set the disassembly flavor, define the "hook-stop" function, and jump into the "main" function (the one from shellcode.c):

![Screenshot](images/read_file/11.png)

Now, we must jump to the shellcode, so we set a breakpoint in the last 'call eax' instruction visible in the previous screenshot (the previous call instructions show the length of the shellcode).

We continue for one instruction using 'stepi' and the 'disassemble' command shows we have reached the shellcode. All the shellcode with the four syscalls can be read:

![Screenshot](images/read_file/12.png)


### JMP-CALL-POP detected

In 0x00404040 there is a jump (JMP) to 0x404078 which immediately calls 0x00404042. This is obviously a JMP-CALL-POP so we will read the values after 0x404078, which contain "/etc/passwd"

![Screenshot](images/read_file/13.png)

Now, we will set a breakpoint before every syscall: 0x0040404a, 0x0040405c, 0x0040406a and 0x00404076.

![Screenshot](images/read_file/14.png)


### Syscall 1

We reach the first syscall:

![Screenshot](images/read_file/15.png)

We read the man page of open:

![Screenshot](images/read_file/16.png)

And then the values are:

- EAX = 5 => Syscall is open()

- EBX = 4210813 => The address of "/etc/passwd" string

![Screenshot](images/read_file/17.png)

- ECX = 0 => These are the flags values. In this case it is only needed the read permission.


### Syscall 2

We reach the second syscall:

![Screenshot](images/read_file/18.png)

We read the man page of read:

![Screenshot](images/read_file/19.png)

And then the values are:

- EAX = 3 => Syscall is read()

- EBX = 3 => File descriptor to use

- ECX = -1073745156 => Contains the value of the file read (the content of the stack)

- EDX = 4096 => 4096 bytes will be read


### Syscall 3

We reach the third syscall:

![Screenshot](images/read_file/20.png)

We read the man page of write in here: https://linux.die.net/man/2/write

And then the values are:

- EAX = 4 => Syscall is write()

- EBX = 1 => File descriptor is 1 (STDIN)

- ECX = -1073745156 => Address of the characters to write

- EDX = -14 => In the address 0x0040405e, EAX value is copied to EDX because read() on success returns the number of bytes read. In this case, the read() syscall returns -14. 


### Syscall 4

We reach the fourth syscall:

![Screenshot](images/read_file/21.png)

We read the man page of exit:

![Screenshot](images/read_file/22.png)

And then the values are:

- EAX = 1 => Syscall is exit()

- EBX = 0 => Status 0 will represent the program finished correctly in this case.



### Update/correct NASM file

Now we can update the nasm code deleting the unused opcodes and adding the string we found.

![Screenshot](images/read_file/24.png)

Finally we can compile the nasm file and check it works correctly:

![Screenshot](images/read_file/25.png)