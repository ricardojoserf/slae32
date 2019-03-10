#!/bin/bash

old_path=`pwd`
cd ~/slae/libemu/tools/sctest/  && $1 | ./sctest -vvv -Ss 10000 -G $2.dot
cd $old_path
cp ~/slae/libemu/tools/sctest/$2.dot .
dot $2.dot -T png -o $2.png