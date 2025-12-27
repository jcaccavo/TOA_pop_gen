inPath=".../13_final_mapping/STACKS_input_files"
outPath=".../14_Stacks"
popmap=".../popmap.txt"
Refmap=".../ref_map.pl"

PREFIX="subarea_p3"
mkdir $outPath/$PREFIX
mkdir $outPath/$PREFIX/p1r0.6 ${outPath}/$PREFIX/p1r0.6singleSNP ${outPath}/$PREFIX/p1r0.6maf0.05

$Refmap -T 52 -o ${outPath}/$PREFIX/p1r0.6 --popmap $popmap_subarea --samples ${inPath} -X "populations:-p 1 -r 0.6 --vcf"
$Refmap -T 52 -o ${outPath}/$PREFIX/p1r0.6singleSNP --popmap $popmap_subarea --samples ${inPath} -X "populations:-p 1 -r 0.6 --vcf --write-single-snp"
$Refmap -T 52 -o ${outPath}/$PREFIX/p1r0.6maf0.05 --popmap $popmap_subarea --samples ${inPath} -X "populations:-p 1 -r 0.6 --min-maf 0.05 --vcf"
