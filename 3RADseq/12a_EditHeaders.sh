#!/bin/bash
inPath="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/11_CheckRestSites"
outPath="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/12_Filter3rdEnzyme"

for r1 in ${inPath}/*_R1_checkrestsites.fastq;do
        r2=$(echo $r1 | sed 's/_R1_checkrestsites.fastq/_R2_checkrestsites.fastq/')
        FILE1=$(basename $r1)
        FILE2=$(basename $r2)
	echo $r1
	echo $FILE1
	echo $FILE2
        OUT1=${FILE1/_R1_checkrestsites.fastq/.R1.fastq}
        OUT2=${FILE2/_R2_checkrestsites.fastq/.R2.fastq}
        echo $OUT1
        echo $OUT2
        cat $r1 | sed '/^@A/ s/\s.*$//' > ${outPath}/${OUT1}
        cat $r2 | sed '/^@A/ s/\s.*$//' > ${outPath}/${OUT2}
done
