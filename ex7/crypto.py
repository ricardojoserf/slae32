import base64
import hashlib
from Crypto.Cipher import AES
import Crypto
from Crypto.PublicKey import RSA

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


class RSACipher(object):

	def encrypt(self, message):
		f = open('public.pem', 'rb')
		publickey = RSA.importKey(f.read())
		encrypted = publickey.encrypt(message, 32)
		return encrypted

	def decrypt(self, enc_message):
		f = open('private.pem', 'rb')
		private = RSA.importKey(f.read())
		decrypted = private.decrypt(enc_message)
		return decrypted

