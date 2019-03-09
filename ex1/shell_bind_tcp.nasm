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

	; Print hello world using write syscall

	mov eax, 0x4
	mov ebx, 1
	mov ecx, message
	mov edx, mlen
	int 0x80

	mov [cArray+0], dword AF_INET
	mov [cArray+4], dword SOCK_STREAM
	mov [cArray+8], dword 0
	mov eax, SYS_socketcall
	mov ebx, SYS_SOCKET
	mov ecx, cArray
	int 0x80
	mov dword [socket], eax


	mov eax, 0x361
	mov ebx, 1
	mov ecx, message2
	mov edx, mlen2
	int 0x80


	mov eax, 0x4
	mov ebx, 1
	mov ecx, message2
	mov edx, mlen2
	int 0x80


	mov eax, 1
	mov ebx, 10		; sys_exit syscall
	int 0x80

section .data

	message: db "Creating socket...",0xA
	mlen     equ $-message
	message2: db "Binding socket...",0xA
	mlen2     equ $-message2


section .bss
	;general 'array' for syscall_socketcall argument arg.
	socket resd 1

	cArray	resd 1
			resd 1
			resd 1
			resd 1
 