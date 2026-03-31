#!/bin/sh
cd `dirname $0`
rm -f *.inp

sumtally='sumtally'
factor='1.0'
sfile='result.out'
surfacex='surfacex'
surfacey='surfacey'
surfacez='surfacez'
output='output/deposit_target'
cell='cell'
RemovedCell='RemovedCell'
sharp='     #'
StartNumber1='1000'
StartNumber2='2000'
StartNumber3='3000'
MatInfo='3 -11.34'
c1='*c1'
c2p='+c2'
c2m='-c2'
c3p='+c3'
c4p='+c4*'
c5p='+c5*'
c8='c8'
c9='c9'
pz1='4001'
pz2='4002'

nTrans=1
nUniv=1
nTLeaves=60
nTLeaves1=$(( $nTLeaves+1))
nLeavesIn=32
nLeavesOut=28
nLeavesA=$(( $nLeavesOut/2 ))
nLeavesA1=$(( $nLeavesA+1 ))
nLeavesB=$(( $nLeavesA+$nLeavesIn ))
nLeavesB1=$(( $nLeavesB+1 ))
nread=0
tnStep=0
nStep=0

echo "$StartNumber3" py "$c8" >> $surfacey.inp
echo "$pz1" pz "$c9" >> $surfacez.inp
echo "$pz2" pz "$c9""$c3p" >> $surfacez.inp


# echo 'Input filename ? - Type filename & ENTER -'

#nkf --unix --overwrite $INPUT

while IFS=, read dum1 dum2 dum3 dum4 dum5
do

  nread=$(( $nread+1 ))
  nreadm=$(( $nread-1 ))

 if [ $tnStep = 0 ]
 then

  if [ $nread = 2 ]
  then
   tnStep=$(( dum1))
   nStep=1
   nread=0
  fi

 else
  if [ $nread = 1 ]
  then
   snum1=$StartNumber1
   snum2=$StartNumber2
   snum3=$StartNumber3

  elif [ $nread -ge 2 ]
  then
   snum1=$(( $snum1+1 ))
   snum2=$(( $snum2+1 ))
   snum3=$(( $snum3+1 ))
   snum3m=$(( $snum3-1 ))

   echo "$snum1 px $dum1$c1$c2m" >> $surfacex$nStep.inp
   echo "$snum2 px $dum1$c1" >> $surfacex$nStep.inp

   if [ $nStep = 1 ]
   then

    echo "$snum1 $MatInfo $snum1 -$snum2 $snum3m -$snum3 $pz1 -$pz2 u=$nUniv" >> $cell.inp
    echo "$sharp$snum1" >> $RemovedCell.inp

    if [ $nread -le $nLeavesA1 ]
    then
     echo "$snum3 py $c8$c5p$nreadm" >> $surfacey.inp

    elif [ $nread -gt $nLeavesA1 ] && [ $nread -le $nLeavesB1 ]
    then
     nLeaves=$(( $nreadm -$nLeavesA ))
     echo "$snum3 py $c8$c5p$nLeavesA$c4p$nLeaves" >> $surfacey.inp

    else
     nLeaves=$(( $nreadm -$nLeavesA -$nLeavesIn ))
     echo "$snum3 py $c8$c5p$nLeavesA$c4p$nLeavesIn$c5p$nLeaves" >> $surfacey.inp
    fi
   fi

   snum1=$(( $snum1+1 ))
   snum2=$(( $snum2+1 ))
   echo "$snum1 px $dum2$c1" >> $surfacex$nStep.inp
   echo "$snum2 px $dum2$c1$c2p" >> $surfacex$nStep.inp

   if [ $nStep = 1 ]
   then
    echo "$snum1 $MatInfo $snum1 -$snum2 $snum3m -$snum3 $pz1 -$pz2 u=$nUniv" >> $cell.inp
    echo "$sharp$snum1" >> $RemovedCell.inp
   fi

   if [ $nread = $nTLeaves1 ]
   then
    echo "Step $nStep finished"
    nread=0
    nStep=$(( $nStep+1 ))
   fi

  fi
 fi
done < MultiLeaf.dat


echo "sumtally start" >> $sumtally.inp
echo "isumtally = 2" >> $sumtally.inp
echo "sfile = $sfile" >> $sumtally.inp
echo "sumfactor = $factor" >> $sumtally.inp
nfile=$(( $tnStep-1 ))
echo "nfile = $nfile" >> $sumtally.inp

nread=0
nStep=0

cat Angle.dat | while IFS=, read dum1 dum2 dum3 dum4 dum5 dum6 dum7 dum8
do

 nread=$(( $nread+1 ))

 if [ $nread -ge 7 ]
 then

  nStep=$(( $nStep+1 ))
  nStepm=$(( $nStep-1 ))

  if [ $nStep -le $tnStep ]
  then
   echo "set: c10[-$dum5]" >> trans-G$nStep.inp
   echo "set: c10[$dum6]" >> trans-C$nStep.inp

   if [ $nStep -gt 1 ]
   then
    echo "$output-$nStepm.out $dum8-$weight" >> $sumtally.inp
   fi
   weight=${dum8}
   weight=`echo $weight`

  fi
 fi
done

echo "sumtally end" >> $sumtally.inp

echo "- push ENTER key to end -"
read WAIT
exit
