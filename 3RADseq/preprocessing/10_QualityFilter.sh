T="java -jar .../trimmomatic-0.38.jar"
inPath=".../09_CorrectOrientation"
outPath=".../10_SizeAndQualityFilter"

Q=30

for R1 in $inPath/*.unassembled.forward.fastq.gz;do
        R2=${R1/forward/reverse}
        FILE=$(basename $R1)
        echo $basename
        R1_paired=${FILE/.unassembled.forward.fastq.gz/_R1_Q$Q.paired.fastq.gz}
        R2_paired=${FILE/.unassembled.forward.fastq.gz/_R2_Q$Q.paired.fastq.gz}
        R1_unpaired=${FILE/.unassembled.forward.fastq.gz/_R1_Q$Q.unpaired.fastq.gz}
        R2_unpaired=${FILE/.unassembled.forward.fastq.gz/_R2_Q$Q.unpaired.fastq.gz}
        $T PE -threads 50 -phred33 $R1 $R2 $outPath/$R1_paired $outPath/$R1_unpaired $outPath/$R2_paired $outPath/$R2_unpaired AVGQUAL:${Q} MINLEN:140 CROP:140
done
