@echo off

SET  PHITSEXE="C:\phits\bin\phits289_win.exe"

for /l %%i in (1, 1, 3) do (

%PHITSEXE% < lec0%%i.inp
copy phits.out phits%%i.out

)

pause
exit
