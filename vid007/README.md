# gdb commands

## General

gdb /bin/bash

break main

run

info registers

display /x $eax

display /x $ax

display /x $ecx

display /x $ch

display /x $cl


## Eip

info registers

disassemble $eip


## Fpu 

info all-registers


## Set flavour

set disassembly-flavour intel
