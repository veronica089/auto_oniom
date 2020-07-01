#!/bin/bash
##the parameters will be created only for $ref


notended=`grep -L "Normal termination" *oniom.log`
   for i in $notended
       do
         rm $i
       done

