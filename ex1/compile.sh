#!/bin/bash

echo '[+] Assembling with Nasm ... '
nasm -f elf32 -o shell_bind_tcp.o shell_bind_tcp.nasm

echo '[+] Linking ...'
ld -o shell_bind_tcp shell_bind_tcp.o

echo '[+] Done!'

rm shell_bind_tcp.o
./shell_bind_tcp