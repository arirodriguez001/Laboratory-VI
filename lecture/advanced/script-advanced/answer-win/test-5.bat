@echo off

set /a iii=2

for /f "tokens=1-3" %%a in (file.txt) do (

echo %%a %%b %%c >> file%iii%.txt

)

pause
exit
