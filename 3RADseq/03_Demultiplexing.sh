#!/bin/bash

INPUT=".../02a_AdapterTrimming"
OUTPUT=".../03_demultiplexingInlineBarcode"
INDEX_P5=".../Internal_indexes_P5.fasta"
INDEX_P7=".../Internal_indexes_P7.fasta"
LOG=".../03_demultiplexingInlineBarcode/flexbar.log"

for READ1 in $INPUT/*_R1_AT.fastq.gz;do
	READ2=${READ1/_R1/_R2}
	echo $READ1
	echo $READ2
	FILE=$(basename $READ1)
	SAMPLE=${FILE/_R1_AT.fastq.gz/}
	flexbar -r $READ1 -p $READ2 -b $INDEX_P5 -b2 $INDEX_P7 -t ${OUTPUT}/$SAMPLE -bt LTAIL -u 2 -n 40
done
