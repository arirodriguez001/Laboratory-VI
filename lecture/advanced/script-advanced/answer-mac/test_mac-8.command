#!/bin/sh
cd `dirname $0`

PHITSEXE="/Users/***/phits/bin/phits289_mac.exe"

for i in $(seq 1 3)
do

$PHITSEXE < lec0${i}.inp
cp phits.out phits${i}.out

done

echo "- push ENTER key to end -"
read WAIT
exit
