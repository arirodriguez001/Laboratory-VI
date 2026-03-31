@echo off

set aaa=Hello PHITS world
set /a iii=1
set /a iii=iii+1
echo %aaa% > file%iii%.txt

pause
exit
