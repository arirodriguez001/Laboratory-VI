@echo off

SET PHITSEXE="C:\phits\bin\phits288_win.exe"
SET OUTDIR="output"

copy MultiLeafCollimator\cell.inp .
copy MultiLeafCollimator\sumtally.inp .
copy MultiLeafCollimator\RemovedCell.inp .

for /l %%i in (1, 1, 9) do (

echo Calculating %%i ...

copy MultiLeafCollimator\surfacex%%i.inp surfacex.inp

%PHITSEXE% < IMRT.inp

move phits.out %OUTDIR%\phits-%%i.out
move deposit_xy.out %OUTDIR%\deposit_xy-%%i.out
move deposit_xy_err.out %OUTDIR%\deposit_xy-%%i_err.out

)

pause
exit
