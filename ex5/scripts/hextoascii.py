#!/usr/bin/env python

import sys

while 1:
	input_ = raw_input("")
	print input_.replace("0x","").decode("hex")[::-1]