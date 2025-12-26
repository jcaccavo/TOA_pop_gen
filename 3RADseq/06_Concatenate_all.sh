#!/bin/bash
inPath=".../05_PCRduplicatesFilter"
outPath="/.../06_Concatenated"

cd $inPath

INDIVs="Unique sample identifiers, listed out with a space between each identifier, i.e.,: 204 203 199 198 196 etc."

for INDIV in $INDIVs;do
        cat *${INDIV}_1_PCRfiltered.fastq.gz > ${outPath}/${INDIV}_concat_R1.fastq.gz
	cat *${INDIV}_2_PCRfiltered.fastq.gz > ${outPath}/${INDIV}_concat_R2.fastq.gz
done
