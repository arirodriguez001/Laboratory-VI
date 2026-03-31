#!/bin/sh
cd `dirname $0`

aaa="Hello PHITS world"
iii=1
iii=$(( $iii+1 ))
echo $aaa > file${iii}.txt

echo "- push ENTER key to end -"
read WAIT
exit
