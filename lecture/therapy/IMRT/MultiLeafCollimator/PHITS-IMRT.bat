@echo off
setlocal ENABLEDELAYEDEXPANSION
cd "%~dp0"


del *.inp

set sumtally=sumtally
set factor=1.0
set sfile=result.out
set surface=surfacex
set output=output/deposit_xy
set cell=cell
set RemovedCell=RemovedCell
set sharp=     #
set StartNumber1=1000
set StartNumber2=2000
set StartNumber3=3000
set MatInfo=3 -11.34
set c1A=*(-1)*c1
set c1B=*c1
set c2p=+c2
set c2m=-c2
set pz1=4001
set pz2=4002

echo sumtally start >> !sumtally!.inp
echo isumtally = 2 >> !sumtally!.inp

set /a num=0

for /f "tokens=1-5*" %%i in (%1) do (

 if "%%i %%j %%k" == "Number of Fields" (
  set /a nfile=%%m-1
  echo nfile = !nfile! >> !sumtally!.inp
  echo Number of Fields: %%m

 ) else if "%%i %%j %%k" == "Number of Leaves" (
  set /a nLeaves=%%m
  set /a nLeaves2=%%m/2
  echo Number of Leaves: %%m

 ) else if %%i == Field (
  set /a num+=1
  set /a numm=!num!-1
  set /a lnuma=0
  set /a lnumb=-!nLeaves2!
  set /a snum1=!StartNumber1!
  set /a snum2=!StartNumber2!
  set /a snum3=!StartNumber3!
  echo Field: !num!

 ) else if %%i == Index (
  if not !num! == 1 (
   echo !output!-!numm!.out %%k-!weight! >> !sumtally!.inp
  )
  set weight=%%k

 ) else if %%i == Leaf (
  set /a lnuma+=1
  set /a lnumb+=1
  set /a snum1+=1
  set /a snum2+=1

  if !lnuma! LEQ !nLeaves2! (
   echo !snum1! px %%l!c1A!!c2m! >> !surface!!num!.inp
   echo !snum2! px %%l!c1A! >> !surface!!num!.inp
   set /a snum3+=1

   if !num! == 1 (
    set /a snum3m=!snum3!-1
    echo !snum1! !MatInfo! !snum1! -!snum2! !snum3m! -!snum3! !pz1! -!pz2! >> !cell!.inp
    echo !sharp!!snum1! >> !RemovedCell!.inp
   )

  ) else if !lnuma! LEQ !nLeaves! (
   echo !snum1! px %%l!c1B! >> !surface!!num!.inp
   echo !snum2! px %%l!c1B!!c2p! >> !surface!!num!.inp
   if !lnumb! == 1 (
    set /a snum3=!StartNumber3!
   )
   set /a snum3+=1

   if !num! == 1 (
    set /a snum3m=!snum3!-1
    echo !snum1! !MatInfo! !snum1! -!snum2! !snum3m! -!snum3! !pz1! -!pz2! >> !cell!.inp
    echo !sharp!!snum1! >> !RemovedCell!.inp
   )
  )
 )
)

echo sfile = !sfile! >> !sumtally!.inp
echo sumfactor = !factor! >> !sumtally!.inp
echo sumtally end >> !sumtally!.inp


endlocal
pause
exit
