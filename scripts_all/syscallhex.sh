#!/bin/bash

decimal=`cat /usr/include/i386-linux-gnu/asm/unistd_32.h | grep $1 | cut -d " " -f 3`
echo $decimal
printf "0x%x\n" $decimal
