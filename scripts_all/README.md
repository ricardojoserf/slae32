# Scripts


## Script *clean.sh*

Extract shellcode from binary

Usage:
```
sh clean.sh $BINARY
```


## Script *compile.sh*

Compile .nasm file and execute it

Usage:
```
sh clean.sh $NASM_FILE
```

## Script *hextoascii.py*

Translate the text you write from ASCII to hexadecimal

Usage:
```
./hextoascii.py
```


## Script *install_dependencies.sh*

Install all the needed dependecies and Libemu.

Usage:
```
sh install_dependencies.sh
```


## Script *libemu.sh*

Move to the libemu folder, create the .dot and .png files. *Note*: Change the folder before executing

Usage:
```
sh libemu.sh $COMMAND
```


## Script *objdump.sh*

Execute objdump and set the Intel architecture

Usage:
```
sh objdump.sh $BINARY
```

## File *shellcode.c*

C file from the course, to generate the executables:


## Script *shellcodesize.sh*

Count the number of the letter 'x' in the shellcode of a binary:

Usage:
```
sh shellcodesize.sh $BINARY
```


## Script *syscallhex.sh*

Get the decimal and hexadecimal value of a system call in */usr/include/i386-linux-gnu/asm/unistd_32.h*

Usage:
```
sh syscallhex.sh $SYSCALL
```
