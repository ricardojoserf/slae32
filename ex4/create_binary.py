#!/usr/bin/python
import os
import sys

def create_new_file(shellcode):
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


shellcode = os.popen('sh compile.sh').read().splitlines()[0]
create_new_file(shellcode)

os.system("rm s")
os.system("gcc -fno-stack-protector -z execstack shellcode.c -o shellcode")