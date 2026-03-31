#!/bin/sh
# Usage: autorun.sh

PHITSEXE="/Users/***/phits/bin/phits289_mac.exe"
OUTDIR="output"

cd `dirname $0`

cp "MultiLeafCollimator/cell.inp" .
cp "MultiLeafCollimator/sumtally.inp" .
cp "MultiLeafCollimator/RemovedCell.inp" .

for i in $(seq 1 9)
do
echo "Calculating ${i} ..."

cp "MultiLeafCollimator/surfacex${i}.inp" surfacex.inp

$PHITSEXE < IMRT.inp

mv phits.out "$OUTDIR/phits-${i}.out"
mv deposit_xy.out "$OUTDIR/deposit_xy-${i}.out"
mv deposit_xy_err.out "$OUTDIR/deposit_xy-${i}_err.out"

done

echo "- push ENTER key to end -"
read WAIT
exit
