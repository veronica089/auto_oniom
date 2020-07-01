#!/bin/bash
##the parameters will be created only for $ref



############ modify me ##############
#####################################
name="closest_"
start_frame=2500
end_frame=2950
offset=50
QMmask="QMmask.h"
Movemask="what_moves_mask.f"
MOL2ONIOMHOME="/home/veronica/molecolab_tools/amber2gau/dev"
CROMHOME="../../../../1PREP/7_frcmod_FF14"
PARMHOME="../../../../CRISTALLO/FF14/OPT-LBV-CYX"
#####################################
#####################################

#printf -v nref "%04d" $start_frame
#ref="$name$nref".mol2
#echo "reference mol2 file is $ref"



###### mol2oniom on reference frame ########################################
############################################################################
#/home/veronica/molecolab_tools/misc/converterminal.py $ref -o ref.mol2 

#echo "mol2oniom --> creating ref.connect.inc and ref.param.inc"
#$MOL2ONIOMHOME/mol2oniom.py $ref -v -o ref \
#             -f $CROMHOME/LBVCYX.frcmod \
#		$PARMHOME/gaff.dat \
#	        $PARMHOME/parm14ipq.dat \
#              --softonly  \
#	     --H-mask-file $QMmask --F-mask-file $Movemask \
#	     --vmd-mask -vvv > prepare_ref.log
#
#
#cat ref.connect.inc ref.param.inc > ref_con_par.inc
###########################################################################



############################################################################
###### mol2oniom on trajectory's frames ####################################

i=$start_frame
while  [[ $i -le $end_frame ]]
do
	printf -v j "%04d" $i
	echo "processing" $j "frame"
       #I need to use converter only on these mol2 because I'll need for qmip
        $MOL2ONIOMHOME/mol2oniom.py $name$j.mol2 -v -o $name$j \
        -f $CROMHOME/LBVCYX.frcmod \
           $PARMHOME/gaff.dat \
           $PARMHOME/parm14ipq.dat \
        -n --softonly  \
        --H-mask-file $QMmask --F-mask-file $Movemask \
        --vmd-mask -vvv > prepare.log

        cat header.com $name$j.atcoord.inc ref_con_par.inc > $name$j.oniom.com
        rm $name$j.atcoord.inc
	rm $name$j.param.inc
	rm $name$j.connect.inc
      
       
       	((i = i + $offset))
        
done
#############################################################################
#############################################################################



echo ""
echo "Remember to check charge and multeplicity in the .com files"
echo "Good luck!"
echo ""

#rm ref.atcoord.inc
#rm ref.connect.inc
#rm ref.param.inc


