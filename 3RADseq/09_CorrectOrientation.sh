#!/bin/bash

inPath=".../08_Merging"
outPath=".../09_CorrectOrientation"

cd $inPath

for R1 in $inPath/*.unassembled.forward.fastq.gz;do
        R2=${R1/forward./reverse.}
        FILE=$(basename $R2)
        cp $R1 $outPath
        echo $FILE
	echo $R2
        python2 .../SeqIO_reverseComplement.py $R2 $outPath/$FILE
done
