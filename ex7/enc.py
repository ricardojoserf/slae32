import os,sys
from crypto import *

aes_key = 'r'*16
pkeyname="public.pem"


def create_key():
	f= open(pkeyname,"w+")
	f.write('-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtS5K6YGROGa01x8HhPo2\nkaKn+Gme3ihCI7dieh09iaAphXbjhNsKuE309J8nFZKecuImfQt8bERmerd9ndom\nmIQfJSY9iCzhEOhL5xsSOfqEzFaYBTcRdpgKNQBwk7BCsRjSuN8MPvuwaPKG9FxF\nTOo5lEGz+lFUlhKeVk8YFl8KQCr7RNleQ4I+ZHp/3qWWNlD5CGY5O7h7H2j6Ylgw\nDSCmx4yO0xVEV0OHAZkyM4zZzay03/bfYpcnmWUrN2nWlRfHQ6h1uIjjCo5Xafmr\n6veSASe95V+9uU9FOGFrJggDQSX9zLzJfzUoqla429Zd6D4h2zIf0Oyu7srxRBQx\nIQIDAQAB\n-----END PUBLIC KEY-----\n')
	f.close()


def encrypt_(message):
	enc_message = RSACipher().encrypt(str(AESCipher(aes_key).encrypt(message)).encode('utf-8'))
	return enc_message


def main():
	create_key()
	enc_message = encrypt_(sys.argv[1])
	print enc_message
	#os.system("rm "+pkeyname)

if __name__== "__main__":
  main()
