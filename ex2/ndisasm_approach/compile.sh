#!/bin/bash


echo '[+] Assembling with Nasm ... '
nasm -f elf32 -o ndisasm_shell_reverse_tcp.o ndisasm_shell_reverse_tcp.nasm

echo '[+] Linking ...'
ld -o ndisasm_shell_reverse_tcp ndisasm_shell_reverse_tcp.o

echo '[+] Done!'


rm ndisasm_shell_reverse_tcp.o


echo ''
