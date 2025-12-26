#!/bin/bash

dataPath="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/06_Concatenated"
outPath="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/08_Merging"

cd "/srv/public/shared/software/bin/pear-0.9.11-linux-x86_64/bin"

for R1 in $dataPath/*R1.fastq;do
	R2=${R1/R1./R2.}
	FILE=$(basename $R1)
	SAMPLE=${FILE/_concat_R1.fastq/}
        echo $R1
        echo $R2
        echo $FILE
        echo $SAMPLE
	./pear -j 50 -n 30 -m 310 -v 10 -f $R1 -r $R2 -o $outPath/${SAMPLE} >> $outPath/pear.log
done
