#!/bin/bash

inPath="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/08_Merging"
outPath="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/09_CorrectOrientation"

cd $inPath

for R1 in $inPath/*.unassembled.forward.fastq;do
        R2=${R1/forward./reverse.}
        FILE=$(basename $R2)
        cp $R1 $outPath
        echo $FILE
	echo $R2
        python2 /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/x_scripts/SeqIO_reverseComplement.py $R2 $outPath/$FILE
done
