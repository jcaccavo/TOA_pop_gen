#!/bin/bash

dataPath=".../06_Concatenated"
outPath=".../08_Merging"

cd ".../directory where pear is located"

for R1 in $dataPath/*R1.fastq.gz;do
	R2=${R1/R1./R2.}
	FILE=$(basename $R1)
	SAMPLE=${FILE/_concat_R1.fastq.gz/}
        echo $R1
        echo $R2
        echo $FILE
        echo $SAMPLE
	./pear -j 50 -n 30 -m 310 -v 10 -f $R1 -r $R2 -o $outPath/${SAMPLE} >> $outPath/pear.log
done
