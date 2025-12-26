#!/bin/bash
inPath=".../12_Filter3rdEnzyme"

for FASTQ in ${inPath}/*R1.fastq.gz; do
        FILE=$(basename $FASTQ)
        OUT=${FILE/.R1.fastq.gz/}
        echo $FILE
        grep -e "CCGG\|ATCGAT\|GAATTC" ${inPath}/${FILE} -B1 | grep "^@A0" > ${inPath}/RestSite_Headers_${OUT}.txt
done

for FASTQ in ${inPath}/*R2.fastq.gz; do
        FILE=$(basename $FASTQ)
        OUT=${FILE/.R2.fastq.gz/}
        echo $FILE
        grep -e "CCGG\|ATCGAT\|GAATTC" ${inPath}/${FILE} -B1 | grep "^@A0" >> ${inPath}/RestSite_Headers_${OUT}.txt
done
