inPath="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/13_final_mapping/STACKS_input_files"
outPath="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/14_Stacks"
#popmap_area="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/x_scripts/popmap_area.txt"
#popmap_region="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/x_scripts/popmap_region.txt"
popmap_subarea="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/x_scripts/popmap_subarea.txt"
#popmap_location="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/x_scripts/popmap_location.txt"
Refmap="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/x_scripts/ref_map.pl"

#PREFIX="area_p1"
#PREFIX="region_p2"
PREFIX="subarea_p3"
#PREFIX="location_p6"
mkdir $outPath/$PREFIX
mkdir $outPath/$PREFIX/p1r0.6 ${outPath}/$PREFIX/p1r0.6singleSNP ${outPath}/$PREFIX/p1r0.6maf0.05

$Refmap -T 52 -o ${outPath}/$PREFIX/p1r0.6 --popmap $popmap_subarea --samples ${inPath} -X "populations:-p 1 -r 0.6 --vcf"
$Refmap -T 52 -o ${outPath}/$PREFIX/p1r0.6singleSNP --popmap $popmap_subarea --samples ${inPath} -X "populations:-p 1 -r 0.6 --vcf --write-single-snp"
$Refmap -T 52 -o ${outPath}/$PREFIX/p1r0.6maf0.05 --popmap $popmap_subarea --samples ${inPath} -X "populations:-p 1 -r 0.6 --min-maf 0.05 --vcf"
