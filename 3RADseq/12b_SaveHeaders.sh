#!/bin/bash
inPath="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/12_Filter3rdEnzyme"

for FASTQ in ${inPath}/*R1.fastq; do
        FILE=$(basename $FASTQ)
        OUT=${FILE/.R1.fastq/}
        echo $FILE
        grep -e "CCGG\|ATCGAT\|GAATTC" ${inPath}/${FILE} -B1 | grep "^@A0" > ${inPath}/RestSite_Headers_${OUT}.txt
done

for FASTQ in ${inPath}/*R2.fastq; do
        FILE=$(basename $FASTQ)
        OUT=${FILE/.R2.fastq/}
        echo $FILE
        grep -e "CCGG\|ATCGAT\|GAATTC" ${inPath}/${FILE} -B1 | grep "^@A0" >> ${inPath}/RestSite_Headers_${OUT}.txt
done
