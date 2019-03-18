#!/bin/bash

file="2"

echo '[+] Assembling with Nasm ... '
nasm -f elf32 -o $file.o $file.nasm

echo '[+] Linking ...'
ld -o $file $file.o

echo '[+] Done!'

rm $file.o
#./$file
sh clean.sh 2
gcc -fno-stack-protector -z execstack shellcode.c -o poly2
