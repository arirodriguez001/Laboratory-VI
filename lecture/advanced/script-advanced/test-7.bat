@echo off

for /l %%i in (1, 1, 3) do (

copy file.txt file%%i.txt

)

pause
exit
