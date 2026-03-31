@echo off
setlocal ENABLEDELAYEDEXPANSION
cd "%~dp0"


del *.inp

set sumtally=sumtally
set factor=1.0
set sfile=result.out
set surfacex=surfacex
set surfacey=surfacey
set surfacez=surfacez
set output=output/deposit_target
set cell=cell
set RemovedCell=RemovedCell
set sharp=     #
set StartNumber1=1000
set StartNumber2=2000
set StartNumber3=3000
set MatInfo=3 -11.34
set c1=*c1
set c2p=+c2
set c2m=-c2
set c3p=+c3
set c4p=+c4*
set c5p=+c5*
set c8=c8
set c9=c9
set pz1=4001
set pz2=4002

set /a nTrans=1
set /a nUniv=1
set /a nTLeaves=60
set /a nTLeaves1=!nTLeaves!+1
set /a nLeavesIn=32
set /a nLeavesOut=28
set /a nLeavesA=!nLeavesOut!/2
set /a nLeavesA1=!nLeavesA!+1
set /a nLeavesB=!nLeavesA!+!nLeavesIn!
set /a nLeavesB1=!nLeavesB!+1
set /a nread=0
set /a tnStep=0
set /a nStep=0

echo !StartNumber3! py !c8! >> !surfacey!.inp
echo !pz1! pz !c9! >> !surfacez!.inp
echo !pz2! pz !c9!!c3p! >> !surfacez!.inp


for /f "delims=, tokens=1-3*" %%i in (MultiLeaf.dat) do (

 set /a nread+=1
 set /a nreadm=nread-1

 if !tnStep! == 0 (

  if !nread! == 2 (
   set /a tnStep=%%i
   set /a nStep=1
   set /a nread=0
  )

 ) else (

  if !nread! == 1 (
   set /a snum1=!StartNumber1!
   set /a snum2=!StartNumber2!
   set /a snum3=!StartNumber3!

  ) else if !nread! GEQ 2 (
   set /a snum1+=1
   set /a snum2+=1
   set /a snum3+=1
   set /a snum3m=!snum3!-1

   echo !snum1! px %%i!c1!!c2m! >> !surfacex!!nStep!.inp
   echo !snum2! px %%i!c1! >> !surfacex!!nStep!.inp

   if !nStep! == 1 (
    echo !snum1! !MatInfo! !snum1! -!snum2! !snum3m! -!snum3! !pz1! -!pz2! u=!nUniv! >> !cell!.inp
    echo !sharp!!snum1! >> !RemovedCell!.inp

    if !nread! LEQ !nLeavesA1! (
     echo !snum3! py !c8!!c5p!!nreadm! >> !surfacey!.inp
    ) else if !nread! GTR !nLeavesA1! if !nread! LEQ !nLeavesB1! (
     set /a nLeaves=!nreadm!-!nLeavesA!
     echo !snum3! py !c8!!c5p!!nLeavesA!!c4p!!nLeaves! >> !surfacey!.inp
    ) else (
     set /a nLeaves=!nreadm!-!nLeavesA!-!nLeavesIn!
     echo !snum3! py !c8!!c5p!!nLeavesA!!c4p!!nLeavesIn!!c5p!!nLeaves! >> !surfacey!.inp
    )

   )

   set /a snum1+=1
   set /a snum2+=1
   echo !snum1! px %%j!c1! >> !surfacex!!nStep!.inp
   echo !snum2! px %%j!c1!!c2p! >> !surfacex!!nStep!.inp

   if !nStep! == 1 (
    echo !snum1! !MatInfo! !snum1! -!snum2! !snum3m! -!snum3! !pz1! -!pz2! u=!nUniv! >> !cell!.inp
    echo !sharp!!snum1! >> !RemovedCell!.inp
   )

   if !nread! == !nTLeaves1! (
    echo Step !nStep! finished
    set /a nread=0
    set /a nStep+=1
   )

  )
 )
)


echo sumtally start >> !sumtally!.inp
echo isumtally = 2 >> !sumtally!.inp
echo sfile = !sfile! >> !sumtally!.inp
echo sumfactor = !factor! >> !sumtally!.inp
set /a nfile=!tnStep!-1
echo nfile = !nfile! >> !sumtally!.inp

set /a nread=0
set /a nStep=0

for /f "delims=, tokens=1-8*" %%i in (Angle.dat) do (

 set /a nread+=1

 if !nread! GEQ 7 (

  set /a nStep+=1
  set /a nStepm=!nStep!-1

  if !nStep! LEQ !tnStep! (

   echo set: c10[-%%m] >> trans-G!nStep!.inp
   echo set: c10[%%n] >> trans-C!nStep!.inp

   if not !nStep! == 1 (
    echo !output!-!nStepm!.out %%p-!weight! >> !sumtally!.inp
   )
   set weight=%%p
   set weight=!weight:~1!

  )
 )

)

echo sumtally end >> !sumtally!.inp

endlocal
pause
exit
