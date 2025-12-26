#!/bin/bash
inPath=".../11_CheckRestSites"
outPath=".../12_Filter3rdEnzyme"

for r1 in ${inPath}/*_R1_checkrestsites.fastq.gz;do
        r2=$(echo $r1 | sed 's/_R1_checkrestsites.fastq.gz/_R2_checkrestsites.fastq.gz/')
        FILE1=$(basename $r1)
        FILE2=$(basename $r2)
	echo $r1
	echo $FILE1
	echo $FILE2
        OUT1=${FILE1/_R1_checkrestsites.fastq.gz/.R1.fastq.gz}
        OUT2=${FILE2/_R2_checkrestsites.fastq.gz/.R2.fastq.gz}
        echo $OUT1
        echo $OUT2
        cat $r1 | sed '/^@A/ s/\s.*$//' > ${outPath}/${OUT1}
        cat $r2 | sed '/^@A/ s/\s.*$//' > ${outPath}/${OUT2}
done
