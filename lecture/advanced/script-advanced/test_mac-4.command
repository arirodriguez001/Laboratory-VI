#!/bin/sh
cd `dirname $0`

aaa="Hello PHITS world"

echo $aaa > file.txt

echo "- push ENTER key to end -"
read WAIT
exit
