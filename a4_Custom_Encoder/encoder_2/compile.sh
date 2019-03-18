#!/bin/bash

#file="insertion-decoder"
file="$1"

echo '[+] Assembling with Nasm ... '
nasm -f elf32 -o $file.o $file.nasm

echo '[+] Linking ...'
ld  -m elf_i386 -o $file $file.o

echo '[+] Done!'

rm $file.o

objdump -d ./$file|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'

#rm $file

#./$file

gcc -fno-stack-protector -z execstack shellcode.c -o s
