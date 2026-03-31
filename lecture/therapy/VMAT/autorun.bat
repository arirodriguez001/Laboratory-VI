@echo off

SET PHITSEXE="c:\phits\bin\phits284_win.exe"
SET SCRPTDIR="script"
SET OUTDIR="output"
SET TALLY="deposit_target"

copy %SCRPTDIR%\cell.inp .
copy %SCRPTDIR%\RemovedCell.inp .
copy %SCRPTDIR%\surfacey.inp .
copy %SCRPTDIR%\surfacez.inp .
copy %SCRPTDIR%\sumtally.inp .

for /l %%i in (1, 1, 176) do (

echo Calculating %%i ...

copy %SCRPTDIR%\surfacex%%i.inp surfacex.inp
copy %SCRPTDIR%\trans-G%%i.inp trans-G.inp
copy %SCRPTDIR%\trans-C%%i.inp trans-C.inp

%PHITSEXE% < VMAT.inp

move phits.out %OUTDIR%\phits-%%i.out
move %TALLY%.out %OUTDIR%\%TALLY%-%%i.out
move %TALLY%_err.out %OUTDIR%\%TALLY%-%%i_err.out

)

pause
exit
