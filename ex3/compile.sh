#!/bin/bash

file="$1"

echo '[+] Assembling with Nasm ... '
nasm -f elf32 -o $file.o $file.nasm

echo '[+] Linking ...'
ld -o $file $file.o


rm $file.o
#./$file
echo '[+] Done!'

objdump -d ./$file|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-7 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'
