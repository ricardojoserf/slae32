# Exercise 7

## Encryption

In this assignment the encryption chosen is AES-CBC. The programming language is Python because i found an example to execute the shellcode with it.


## Usage

- '-k', '--aes_key': *AES key used*.

- '-e', '--encrypt': *Shellcode to encrypt*.

- '-d', '--decrypt': *Encrypted shellcode to decrypt*.

- '-x', '--execute': *Execute the shellcode after decrypting or not*.


### Encryption

```
python main.py -e "\x31\xc0\x31\xdb\x31\xc9\x31\xd2\x50\x68\x6e\x2f\x73\x68\x68\x2f\x2f\x62\x69\x68\x2f\x2f\x2f\x2f\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd" -k "ricardoricardo11"
```

![Screenshot](images/1.png)


### Decryption

```
python main.py -d 7L8lgzzXoM1KnsFbIFOPgY3PPx8K5aM5IT2HC8ULBrhcYvbTr4/ItEVN6DgDuJ7TY0d9isE2IuHTC3hWMa4lzkbc6toFTdOnhzc9v/YwqRe62L+dqZ8XQWFk5VHl9R+Dr7ctq2BCAqmozxKeDGLd7iojztY0fTpcUy8gCu/Z5Rf4f4L5tsBna8epwgmBr6Op0/4S44ZEnbfiIH/QtEYUqw== -k "ricardoricardo11"  -x
```

![Screenshot](images/2.png)

