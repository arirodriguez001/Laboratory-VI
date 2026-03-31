#!/bin/sh
cd `dirname $0`

aaa="Hello PHITS world"
iii=2

cat file.txt | while read a b c
do

echo $a $b $c >> file${iii}.txt

done

echo "- push ENTER key to end -"
read WAIT
exit
