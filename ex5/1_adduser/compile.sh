#!/bin/bash

file="1"

echo '[+] Assembling with Nasm ... '
nasm -f elf32 -o $file.o $file.nasm

echo '[+] Linking ...'
ld -o $file $file.o

echo '[+] Done!'

