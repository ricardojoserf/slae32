#!/bin/bash


echo '[+] Assembling with Nasm ... '
nasm -f elf32 -o shell_reverse_tcp.o shell_reverse_tcp.nasm

echo '[+] Linking ...'
ld -o shell_reverse_tcp shell_reverse_tcp.o

echo '[+] Done!'


rm shell_reverse_tcp.o

./shell_reverse_tcp

echo ''
