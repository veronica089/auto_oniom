#!/bin/bash
list=`grep -L "NSER" *mol2`
for i in $list
     do
      /home/veronica/molecolab_tools/misc/converterminal.py $i -o conv.mol2
      mv conv.mol2 $i

     done





