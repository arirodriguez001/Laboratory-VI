#!/bin/sh
# Usage: autorun.sh

PHITSEXE="./phits284_mac.exe"
SCRPTDIR="script"
OUTDIR="output"
TALLY="deposit_target"
TALLYERR="deposit_target_err"

cd `dirname $0`

cp "$SCRPTDIR/cell.inp" .
cp "$SCRPTDIR/RemovedCell.inp" .
cp "$SCRPTDIR/surfacey.inp" .
cp "$SCRPTDIR/surfacez.inp" .
cp "$SCRPTDIR/sumtally.inp" .

for i in $(seq 1 176)
do
echo "Calculating ${i} ..."

cp "$SCRPTDIR/surfacex${i}.inp" surfacex.inp
cp "$SCRPTDIR/trans-G${i}.inp" trans-G.inp
cp "$SCRPTDIR/trans-C${i}.inp" trans-C.inp

$PHITSEXE < VMAT.inp

mv phits.out "$OUTDIR/phits-$i.out"
mv $TALLY.out "$OUTDIR/$TALLY-$i.out"
mv $TALLYERR.out "$OUTDIR/$TALLY-${i}_err.out"

done

echo "- push ENTER key to end -"
read WAIT
exit
