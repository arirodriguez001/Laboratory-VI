#!/bin/sh
cd `dirname $0`

aaa="Hello PHITS world"

for i in $(seq 1 3)
do

cp file.txt file${i}.txt

done

echo "- push ENTER key to end -"
read WAIT
exit
