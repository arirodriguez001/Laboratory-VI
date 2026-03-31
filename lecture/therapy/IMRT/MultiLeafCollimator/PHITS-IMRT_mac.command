#!/bin/sh
cd `dirname $0`
rm -f *.inp

sumtally='sumtally'
factor='1.0'
sfile='result.out'
surface='surfacex'
output='output/deposit_xy'
cell='cell'
RemovedCell='RemovedCell'
sharp='     #'
StartNumber1='1000'
StartNumber2='2000'
StartNumber3='3000'
MatInfo='3 -11.34'
c1A='*(-1)*c1'
c1B='*c1'
c2p='+c2'
c2m='-c2'
pz1='4001'
pz2='4002'

echo "sumtally start" >> $sumtally.inp
echo "isumtally = 2" >> $sumtally.inp

num=0

echo 'Input filename ? - Type filename & ENTER -'
read INPUT

#nkf --unix --overwrite $INPUT

cat $INPUT | while read dum1 dum2 dum3 dum4 dum5
do

 if [ "${dum1}" = "Number" ] && [ "${dum2}" = "of" ] && [ "${dum3}" = "Fields" ]
 then
  nfile=$(( dum5 - 1))
  echo "nfile = $nfile" >> $sumtally.inp
  echo "Number of Fields: ${dum5}"

 elif [ "${dum1}" = "Number" ] && [ "${dum2}" = "of" ] && [ "${dum3}" = "Leaves" ]
 then
  nLeaves=$(( dum5 ))
  nLeaves2=$(( dum5 /2 ))
  echo "Number of Leaves: ${dum5}"

 elif [ "${dum1}" = 'Field' ]
 then
  num=$(( $num+1 ))
  numm=$(( $num-1 ))
  lnuma=0
  lnumb=$(( -$nLeaves2 ))
  snum1=$StartNumber1
  snum2=$StartNumber2
  snum3=$StartNumber3
  echo "Field: $num"
 elif [ "${dum1}" = 'Index' ]
 then
  if [ $num != 1 ]
  then
   echo "$output-$numm.out ${dum3}-$weight" >> $sumtally.inp
  fi
  weight=${dum3}

 elif [ "${dum1}" = 'Leaf' ]
 then
  lnuma=$(( $lnuma+1 ))
  lnumb=$(( $lnumb+1 ))
  snum1=$(( $snum1+1 ))
  snum2=$(( $snum2+1 ))

  if [ $lnuma -le $nLeaves2 ]
  then
   echo "$snum1 px $dum4$c1A$c2m" >> $surface$num.inp
   echo "$snum2 px $dum4$c1A" >> $surface$num.inp
   snum3=$(( $snum3+1 ))

   if [ $num = 1 ]
   then
    snum3m=$(( $snum3-1 ))
    echo "$snum1 $MatInfo $snum1 -$snum2 $snum3m -$snum3 $pz1 -$pz2" >> $cell.inp
    echo "$sharp$snum1" >> $RemovedCell.inp
   fi

  elif [ $lnuma -le $nLeaves ]
  then
   echo "$snum1 px $dum4$c1B" >> $surface$num.inp
   echo "$snum2 px $dum4$c1B$c2p" >> $surface$num.inp
   if [ $lnumb = 1 ] 
   then
    snum3=$StartNumber3
   fi
   snum3=$(( $snum3+1 ))

   if [ $num = 1 ]
   then
    snum3m=$(( $snum3-1 ))
    echo "$snum1 $MatInfo $snum1 -$snum2 $snum3m -$snum3 $pz1 -$pz2" >> $cell.inp
    echo "$sharp$snum1" >> $RemovedCell.inp
   fi
  fi
 fi
done

echo "sfile = $sfile" >> $sumtally.inp
echo "sumfactor = $factor" >> $sumtally.inp
echo "sumtally end" >> $sumtally.inp

echo "- push ENTER key to end -"
read WAIT
exit
