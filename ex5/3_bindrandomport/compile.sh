#!/bin/bash

file="3"

echo '[+] Assembling with Nasm ... '
nasm -f elf32 -o $file.o $file.nasm

echo '[+] Linking ...'
ld -o 3 $file.o

echo '[+] Done!'

rm $file.o
