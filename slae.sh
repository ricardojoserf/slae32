#!/bin/bash

cd ~/slae/libemu/tools/sctest/  && echo -ne "$1" && ./sctest -vvv -Ss 10000 -G $2.dot
cp ~/slae/libemu/tools/sctest/$2.dot .
dot $2.dot -T png -o $2.png