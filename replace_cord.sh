#!/bin/bash

#It needs here: closest_$i.oniom.log, closest_$i.mol2, all_$i.mol2"
#Masks start from 0
closest_mask="what_moves_mask.f"
all_mask="box_mask.dat"

  for i in {2750..2750..50}
     do
        log="../closest_$i.oniom.log"
        if [ -f "$log" ]; then
          echo $i
         
        python3 /home/veronica/bin/replace_cord.py -imol2 ../restart/closest_$i.restart.mol2 -omol2 all-noopt/all_$i.mol2 -imask $closest_mask -omask  $all_mask -out all-new/all_$i.new

        fi
     done





    rm *mdcrd
    rm *xyz
