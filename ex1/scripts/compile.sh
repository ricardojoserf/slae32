#!/bin/bash

file="$1"

echo '[+] Assembling with Nasm ... '
nasm -f elf32 -o $file.o $file.nasm

echo '[+] Linking ...'
ld -m elf_i386 -o $file $file.o

echo '[+] Done!'

rm $file.o
#./shell_bind_tcp
