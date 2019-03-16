-e section .text
global _start 
_start
sub eax,0x5c20656e
js 0x3a
xor [eax+edi*2+0x63],ebx
cmp [eax+edi*2+0x38],ebx
cmp [eax+edi*2+0x63],ebx
bound ebx,[eax+edi*2+0x36]
popa
pop esp
js 0x4f
ss pop esp
js 0x54
cmp [eax+edi*2+0x63],bl
fs pop esp
js 0x5f
xor [eax+edi*2+0x36],bl
popa
pop esp
js 0x5f
xor eax,0x3835785c
pop esp
js 0x6a
xor [eax+edi*2+0x63],ebx
cmp [eax+edi*2+0x35],ebx
xor [eax+edi*2+0x36],ebx
cmp [eax+edi*2+0x37],bl
xor ebx,[eax+edi*2+0x37]
xor ebx,[eax+edi*2+0x37]
aaa
pop esp
js 0x89
xor al,0x5c
js 0x8d
cmp [eax+edi*2+0x32],bl
pop sp
js 0x91
pop sp
js 0x9a
xor [eax+edi*2+0x36],bl
xor [eax+edi*2+0x36],ebx
cmp [eax+edi*2+0x32],bl
pop sp
js 0xa9
xor eax,0x3437785c
pop esp
js 0xb1
xor ebx,[eax+edi*2+0x38]
cmp [eax+edi*2+0x65],ebx
xor ebx,[eax+edi*2+0x34]
xor [eax+edi*2+0x62],ebx
xor eax,0x3430785c
pop esp
js 0xf6
fs pop esp
js 0xcf
xor [eax+edi*2+0x39],bl
xor ebx,[eax+edi*2+0x65]
cmp [eax+edi*2+0x32],bl
aaa
pop esp
js 0xd7
xor [eax+edi*2+0x30],bl
xor [eax+edi*2+0x30],bl
xor [eax+edi*2+0x37],bl
xor bl,[eax+edi*2+0x36]
cmp [eax+edi*2+0x36],ebx
xor ebx,[eax+edi*2+0x36]
xor [eax+edi*2+0x37],ebx
xor bl,[eax+edi*2+0x36]
xor al,0x5c
js 0x101
pop sp
js 0x102
popa
pop esp
js 0x107
xor [eax+edi*2+0x37],ebx
popa
pop esp
js 0x112
ss pop esp
js 0x113
xor al,0x5c
js 0x11a
xor bl,[eax+edi*2+0x32]
gs pop esp
js 0x122
xor bl,[eax+edi*2+0x35]
aaa
pop esp
js 0x126
xor ebx,[eax+edi*2+0x35]
xor al,0x5c
js 0x12e
xor al,0x5c
js 0x135
cmp [eax+edi*2+0x36],ebx
xor ebx,[eax+edi*2+0x33]
popa
pop esp
js 0x13e
xor [eax+edi*2+0x33],bl
popa
pop esp
js 0x146
xor [eax+edi*2+0x33],bl
popa
pop esp
js 0x14e
popa
pop esp
js 0x151
pop sp
js 0x156
popa
pop esp
js 0x159
pop sp
js 0x161
xor bl,[eax+edi*2+0x36]
cmp [eax+edi*2+0x36],ebx
gs pop esp
js 0x169
pop sp
js 0x171
xor bl,[eax+edi*2+0x36]
xor [eax+edi*2+0x37],ebx
xor ebx,[eax+edi*2+0x36]
cmp [eax+edi*2+0x30],bl
popa
pop esp
js 0x184
cmp [eax+edi*2+0x38],ebx
bound ebx,[eax+edi*2+0x35]
xor [eax+edi*2+0x66],ebx
arpl [eax+edi*2+0x36],bx
popa
pop esp
js 0x193
xor al,0x5c
js 0x19c
cmp [eax+edi*2+0x63],bl
fs pop esp
js 0x1a7
xor [eax+edi*2+0x36],bl
popa
pop esp
js 0x1a7
xor [eax+edi*2+0x35],ebx
cmp [eax+edi*2+0x63],bl
fs pop esp
js 0x1bb
xor [edx],cl
