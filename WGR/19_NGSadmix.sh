#!/bin/bash

#cd /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/x_scripts/NGSadmix
#
#for K in {2..11};do
#         bash wrapper_ngsAdmix.sh -likes /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/17_ngsLD/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd18_NR_depth_DS5X_unlinked_20_0.5_SNPs.beagle.gz -tol 0.00000000010 -maxiter 5000 -K ${K} -P 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/x_scripts/NGSadmix/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd18_NR_depth_DS5X_unlinked_20_0.5_${K}_50reps
#done
cd /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/x_scripts/NGSadmix

### Full datasets, including non-TOA samples 461 (WGR) and CSB (TOP?) ngsLD min_weight = 0.5

#LD-filtered ANGSD output based on 20a bam fileset: repeat + depth filter, downsampled to 2x (n=39)
#for K in {2..11};do
#         bash wrapper_ngsAdmix.sh -likes /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/17_ngsLD/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd29_NR_depth_DS2X_unlinked_20_0.5_SNPs.beagle.gz -tol 0.00000000010 -maxiter 5000 -K ${K} -P 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/x_scripts/NGSadmix/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd29_NR_depth_DS2X_unlinked_20_0.5_${K}_50reps
#done

#LD-filtered ANGSD output based on 20a bam fileset: repeat + depth filter, downsampled to 5x (n=25)
#for K in {2..11};do
#         bash wrapper_ngsAdmix.sh -likes /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/17_ngsLD/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd18_NR_depth_DS5X_unlinked_20_0.5_SNPs.beagle.gz -tol 0.00000000010 -maxiter 5000 -K ${K} -P 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/x_scripts/NGSadmix/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd18_NR_depth_DS5X_unlinked_20_0.5_${K}_50reps
#done

### Trimmed datasets, including only TOA samples ngsLD min_weight = 0.5

#LD-filtered ANGSD output based on 20a bam fileset: repeat + depth filter, downsampled to 2x (n=37)
#for K in {2..11};do
#         bash wrapper_ngsAdmix.sh -likes /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/17_ngsLD/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd29_NR_depth_DS2X_unlinked_20_0.5_TOA_only_SNPs.beagle.gz -tol 0.00000000010 -maxiter 5000 -K ${K} -P 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/x_scripts/NGSadmix/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd29_NR_depth_DS2X_unlinked_20_0.5_TOA_only_${K}_50reps
#done

#LD-filtered ANGSD output based on 20a bam fileset: repeat + depth filter, downsampled to 5x (n=24)
#for K in {2..11};do
#         bash wrapper_ngsAdmix.sh -likes /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/17_ngsLD/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd18_NR_depth_DS5X_unlinked_20_0.5_TOA_only_SNPs.beagle.gz -tol 0.00000000010 -maxiter 5000 -K ${K} -P 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/x_scripts/NGSadmix/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd18_NR_depth_DS5X_unlinked_20_0.5_TOA_only_${K}_50reps
#done

#LD-filtered ANGSD output based on 23a bam fileset: repeat + depth filter, no downsampling (n=41)
#for K in {2..11};do
#         bash wrapper_ngsAdmix.sh -likes /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/17_ngsLD/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd32_NR_depth_unlinked_20_0.5_TOA_only_SNPs.beagle.gz -tol 0.00000000010 -maxiter 5000 -K ${K} -P 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/x_scripts/NGSadmix/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd32_NR_depth_unlinked_20_0.5_TOA_only_${K}_50reps
#done

#LD-filtered ANGSD output based on 23a bam fileset: repeat + depth filter, no downsampling (n=41) UPDATED COMMANDS
for K in {2..11}; do
    bash wrapper_ngsAdmix.sh \
      -likes /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/17_ngsLD/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd32_NR_depth_unlinked_20_0.5_TOA_only_SNPs_patched.beagle.gz \
      -tol 0.00000000010 \
      -maxiter 5000 \
      -K ${K} \
      -P 40 \
      -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/x_scripts/NGSadmix/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd32_NR_depth_unlinked_20_0.5_TOA_only_${K}_50reps
done

### Standard sample set (from 5X), including only TOA samples (n = 24) ngsLD min_weight = 0.5

#LD-filtered ANGSD output based on 21a bam fileset: repeat + depth filter, downsampled to 2x
#for K in {2..11};do
#         bash wrapper_ngsAdmix.sh -likes /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/17_ngsLD/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd29_NR_depth_DS2X_unlinked_20_0.5_TOA_only_n24_SNPs.beagle.gz -tol 0.00000000010 -maxiter 5000 -K ${K} -P 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/x_scripts/NGSadmix/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd29_NR_depth_DS2X_unlinked_20_0.5_TOA_only_n24_${K}_50reps
#done

#LD-filtered ANGSD output based on 23a bam fileset: repeat + depth filter, no downsampling
#for K in {2..11};do
#         bash wrapper_ngsAdmix.sh -likes /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/17_ngsLD/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd32_NR_depth_unlinked_20_0.5_TOA_only_n24_SNPs.beagle.gz -tol 0.00000000010 -maxiter 5000 -K ${K} -P 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/x_scripts/NGSadmix/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd32_NR_depth_unlinked_20_0.5_TOA_only_n24_${K}_50reps
#done
