#!/bin/bash

#cd /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/17_ngsLD

###### Unlinked SNPs derived from genotype-likelihoods

### Full datasets, including non-TOA samples 461 (WGR) and CSB (TOP?)

#LD-filtered ANGSD output based on 20a bam fileset: repeat + depth filter, downsampled to 2x (n=39)
#pcangsd -b dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd29_NR_depth_DS2X_unlinked_20_0.5_SNPs.beagle.gz -t 40 -o dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd29_NR_depth_DS2X_unlinked_20_0.5_pcangsd_1
#ngsLD settings 20_0.4
#pcangsd -b dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd29_NR_depth_DS2X_unlinked_20_0.4_SNPs.beagle.gz -t 40 -o dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd29_NR_depth_DS2X_unlinked_20_0.4_pcangsd_1

#LD-filtered ANGSD output based on 21a bam fileset: repeat + depth filter, downsampled to 5x (n=25)
#pcangsd -b dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd18_NR_depth_DS5X_unlinked_20_0.5_SNPs.beagle.gz -t 40 -o dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd18_NR_depth_DS5X_unlinked_20_0.5_pcangsd_1
#ngsLD settings 20_0.4
#pcangsd -b dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd18_NR_depth_DS5X_unlinked_20_0.4_SNPs.beagle.gz -t 40 -o dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd18_NR_depth_DS5X_unlinked_20_0.4_pcangsd_1

#LD-filtered ANGSD output based on 22a bam fileset: repeat + depth filter, downsampled to 10x (n=15)

#LD-filtered ANGSD output based on 23a bam fileset: repeat + depth filter, no downsampling (n=43)
pcangsd -b /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/17_ngsLD/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd17_NR_depth_tissue_unlinked_20_0.5_pg1_SNPs.beagle.gz -t 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/19_PCAngsd/01_genotype_likelihoods/02_ngsLD_min_weight_0.5/01_all_samples/noDS/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd32_NR_depth_unlinked_20_0.5_pg1_pcangsd_1
#ngsLD settings 20_0.4
#pcangsd -b dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd32_NR_depth_unlinked_20_0.4_SNPs.beagle.gz -t 40 -o dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd32_NR_depth_unlinked_20_0.4_pcangsd_1

### Trimmed datasets, including only TOA samples

#LD-filtered ANGSD output based on 20a bam fileset: repeat + depth filter, downsampled to 2x (n=37)
#pcangsd -b dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd29_NR_depth_DS2X_unlinked_20_0.5_TOA_only_SNPs.beagle.gz -t 40 -o dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd29_NR_depth_DS2X_unlinked_20_0.5_TOA_only_pcangsd_1
#ngsLD settings 20_0.4
#pcangsd -b dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd29_NR_depth_DS2X_unlinked_20_0.4_TOA_only_SNPs.beagle.gz -t 40 -o dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd29_NR_depth_DS2X_unlinked_20_0.4_TOA_only_pcangsd_1

#LD-filtered ANGSD output based on 21a bam fileset: repeat + depth filter, downsampled to 5x (n=24)
#pcangsd -b dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd18_NR_depth_DS5X_unlinked_20_0.5_TOA_only_SNPs.beagle.gz -t 40 -o dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd18_NR_depth_DS5X_unlinked_20_0.5_TOA_only_pcangsd_1
#ngsLD settings 20_0.4
#pcangsd -b dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd18_NR_depth_DS5X_unlinked_20_0.4_TOA_only_SNPs.beagle.gz -t 40 -o dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd18_NR_depth_DS5X_unlinked_20_0.4_TOA_only_pcangsd_1

#LD-filtered ANGSD output based on 22a bam fileset: repeat + depth filter, downsampled to 10x (n=..)

#LD-filtered ANGSD output based on 23a bam fileset: repeat + depth filter, no downsampling (n=41)
#pcangsd -b dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd32_NR_depth_unlinked_20_0.5_TOA_only_SNPs.beagle.gz -t 40 -o dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd32_NR_depth_unlinked_20_0.5_TOA_only_pcangsd_1
#ngsLD settings 20_0.4
#pcangsd -b dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd32_NR_depth_unlinked_20_0.4_TOA_only_SNPs.beagle.gz -t 40 -o dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd32_NR_depth_unlinked_20_0.4_TOA_only_pcangsd_1

### Standard sample set (from 5X), including only TOA samples (n = 24)

#LD-filtered ANGSD output based on 21a bam fileset: repeat + depth filter, downsampled to 2x
#pcangsd -b dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd29_NR_depth_DS2X_unlinked_20_0.5_TOA_only_n24_SNPs.beagle.gz -t 40 -o dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd29_NR_depth_DS2X_unlinked_20_0.5_TOA_only_n24_pcangsd_1
#ngsLD settings 20_0.4
#pcangsd -b dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd29_NR_depth_DS2X_unlinked_20_0.4_TOA_only_n24_SNPs.beagle.gz -t 40 -o dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd29_NR_depth_DS2X_unlinked_20_0.4_TOA_only_n24_pcangsd_1

#LD-filtered ANGSD output based on 22a bam fileset: repeat + depth filter, downsampled to 10x

#LD-filtered ANGSD output based on 23a bam fileset: repeat + depth filter, no downsampling
#pcangsd -b dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd32_NR_depth_unlinked_20_0.5_TOA_only_n24_SNPs.beagle.gz -t 40 -o dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd32_NR_depth_unlinked_20_0.5_TOA_only_n24_pcangsd_1
#ngsLD settings 20_0.4
#pcangsd -b dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd32_NR_depth_unlinked_20_0.4_TOA_only_n24_SNPs.beagle.gz -t 40 -o dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd32_NR_depth_unlinked_20_0.4_TOA_only_n24_pcangsd_1

###### Unlinked SNPs derived from otolith-derived genotype-likelihoods

### Full datasets, including non-TOA samples 461 (WGR) and CSB (TOP?)

#LD-filtered ANGSD output based on 24 bam fileset: repeat + depth filter, otolith-derived libraries only no downsampling (n=20)
#prune_graph
#pcangsd -b /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/17_ngsLD/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd15_NR_depth_otolith_unlinked_20_0.5_pg1_SNPs.beagle.gz -t 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/19_PCAngsd/01_genotype_likelihoods/02_ngsLD_min_weight_0.5/01_all_samples/noDS/02_otolith/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd15_NR_depth_otolith_unlinked_20_0.5_pg1_pcangsd_1

###### Unlinked SNPs derived from tissue-derived genotype-likelihoods

### Full datasets, including non-TOA samples 461 (WGR) and CSB (TOP?)

#LD-filtered ANGSD output based on 25 bam fileset: repeat + depth filter, tissue-derived libraries only no downsampling (n=23)
#prune_graph
#pcangsd -b /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/17_ngsLD/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd17_NR_depth_tissue_unlinked_20_0.5_pg1_SNPs.beagle.gz -t 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/19_PCAngsd/01_genotype_likelihoods/02_ngsLD_min_weight_0.5/01_all_samples/noDS/03_tissue/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf2_minMaf0.05_SNPpval1e6_minInd17_NR_depth_tissue_unlinked_20_0.5_pg1_pcangsd_1

###### All SNPs derived from genotype calling

### All SNP datasets based on genotypes derived from bcftools (in contrast to all SNP datasets derived from genotype likelihoods generated in ANGSD) including only TOA samples

#filtered bcftools output based on no_repeats_depthfilter_DS2x_TOA_only_bam.filelist, downsampled to 2x (n=37)
#pcangsd -p /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/20_bcftools/2X/02_all_SNPs/2x_TOA_only_filtered_SNPs_all -t 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/19_PCAngsd/05_ngsLD_min_weight_0.5_all/02_TOA_only/2X/2x_TOA_only_filtered_SNPs_all_pcangsd_1

#filtered bcftools output based on no_repeats_depthfilter_DS5x_TOA_only_bam.filelist, downsampled to 5x (n=24)
#pcangsd -p /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/20_bcftools/5X/02_all_SNPs/5x_TOA_only_filtered_SNPs_all -t 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/19_PCAngsd/05_ngsLD_min_weight_0.5_all/02_TOA_only/5X/5x_TOA_only_filtered_SNPs_all_pcangsd_1

#filtered bcftools output based on no_repeats_depthfilter_DS10x_TOA_only_bam.filelist, downsampled to 10x (n=14)
#pcangsd -p /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/20_bcftools/10X/02_all_SNPs/10x_TOA_only_filtered_SNPs_all -t 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/19_PCAngsd/05_ngsLD_min_weight_0.5_all/02_TOA_only/10X/10x_TOA_only_filtered_SNPs_all_pcangsd_1

#filtered bcftools output based on no_repeats_depthfilter_noDS_TOA_only_bam.filelist, no downsampling (n=41)
#pcangsd -p /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/20_bcftools/noDS/02_all_SNPs/noDS_TOA_only_filtered_SNPs_all -t 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/19_PCAngsd/05_ngsLD_min_weight_0.5_all/02_TOA_only/noDS/noDS_TOA_only_filtered_SNPs_all_pcangsd_1

### Neutral SNP datasets, based on pcadapt outlier detection, including only TOA samples (NOTE – plink file as opposed to beagle file input)

#filtered bcftools output based on no_repeats_depthfilter_DS2x_TOA_only_bam.filelist, downsampled to 2x (n=37)
#pcangsd -p /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/20_bcftools/2X/03_neutral_SNPs/2x_TOA_only_filtered_SNPs_Neutral -t 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/19_PCAngsd/03_ngsLD_min_weight_0.5_neutral/02_TOA_only/2X/2x_TOA_only_filtered_SNPs_Neutral_pcangsd_1

#filtered bcftools output based on no_repeats_depthfilter_DS5x_TOA_only_bam.filelist, downsampled to 5x (n=24)
#pcangsd -p /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/20_bcftools/5X/03_neutral_SNPs/5x_TOA_only_filtered_SNPs_Neutral -t 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/19_PCAngsd/03_ngsLD_min_weight_0.5_neutral/02_TOA_only/5X/5x_TOA_only_filtered_SNPs_Neutral_pcangsd_1

#filtered bcftools output based on no_repeats_depthfilter_DS10x_TOA_only_bam.filelist, downsampled to 10x (n=14)
#pcangsd -p /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/20_bcftools/10X/03_neutral_SNPs/10x_TOA_only_filtered_SNPs_Neutral -t 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/19_PCAngsd/03_ngsLD_min_weight_0.5_neutral/02_TOA_only/10X/10x_TOA_only_filtered_SNPs_Neutral_pcangsd_1

#filtered bcftools output based on no_repeats_depthfilter_noDS_TOA_only_bam.filelist, no downsampling (n=41)
#pcangsd -p /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/20_bcftools/noDS/03_neutral_SNPs/noDS_TOA_only_filtered_SNPs_Neutral -t 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/19_PCAngsd/03_ngsLD_min_weight_0.5_neutral/02_TOA_only/noDS/noDS_TOA_only_filtered_SNPs_Neutral_pcangsd_1

### Adaptive SNP datasets, based on pcadapt outlier detection, including only TOA samples (NOTE – plink file as opposed to beagle file input)

#filtered bcftools output based on no_repeats_depthfilter_DS2x_TOA_only_bam.filelist, downsampled to 2x (n=37)
#pcangsd -p /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/20_bcftools/2X/04_adapative_SNPs/2x_TOA_only_filtered_SNPs_Adaptive -t 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/19_PCAngsd/04_ngsLD_min_weight_0.5_adaptive/02_TOA_only/2X/2x_TOA_only_filtered_SNPs_Adaptive_pcangsd_1

#filtered bcftools output based on no_repeats_depthfilter_DS5x_TOA_only_bam.filelist, downsampled to 5x (n=24)
#pcangsd -p /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/20_bcftools/5X/04_adapative_SNPs/5x_TOA_only_filtered_SNPs_Adaptive -t 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/19_PCAngsd/04_ngsLD_min_weight_0.5_adaptive/02_TOA_only/5X/5x_TOA_only_filtered_SNPs_Adaptive_pcangsd_1

#filtered bcftools output based on no_repeats_depthfilter_DS10x_TOA_only_bam.filelist, downsampled to 10x (n=14)
#pcangsd -p /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/20_bcftools/10X/04_adapative_SNPs/10x_TOA_only_filtered_SNPs_Adaptive -t 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/19_PCAngsd/04_ngsLD_min_weight_0.5_adaptive/02_TOA_only/10X/10x_TOA_only_filtered_SNPs_Adaptive_pcangsd_1

#filtered bcftools output based on no_repeats_depthfilter_noDS_TOA_only_bam.filelist, no downsampling (n=41)
#pcangsd -p /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/20_bcftools/noDS/04_adapative_SNPs/noDS_TOA_only_filtered_SNPs_Adaptive -t 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/19_PCAngsd/04_ngsLD_min_weight_0.5_adaptive/02_TOA_only/noDS/noDS_TOA_only_filtered_SNPs_Adaptive_pcangsd_1

###### Unlinked SNPs derived from genotype calling

### All unlinked SNP datasets based on genotypes derived from bcftools including only TOA samples

#unlinked SNPs filtered using bcftools output based on no_repeats_depthfilter_DS2x_TOA_only_bam.filelist, downsampled to 2x (n=37)
#pcangsd -p /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/20_bcftools/2X/02_all_SNPs/02_unlinked_SNPs/2x_TOA_only_filtered_SNPs_all_unlinked -t 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/19_PCAngsd/02_genotypes/01_all_SNPs/02_unlinked_SNPs/2X/2x_TOA_only_filtered_unlinked_SNPs_all_pcangsd_1

# unlinked SNPs filtered using bcftools output based on no_repeats_depthfilter_DS5x_TOA_only_bam.filelist, downsampled to 5x (n=24)
#pcangsd -p /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/20_bcftools/5X/02_all_SNPs/02_unlinked_SNPs/5x_TOA_only_filtered_SNPs_all_unlinked -t 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/19_PCAngsd/02_genotypes/01_all_SNPs/02_unlinked_SNPs/5X/5x_TOA_only_filtered_unlinked_SNPs_all_pcangsd_1

#unlinked SNPs filtered using bcftools output based on no_repeats_depthfilter_DS10x_TOA_only_bam.filelist, downsampled to 10x (n=14)
#pcangsd -p /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/20_bcftools/10X/02_all_SNPs/02_unlinked_SNPs/10x_TOA_only_filtered_SNPs_all_unlinked -t 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/19_PCAngsd/02_genotypes/01_all_SNPs/02_unlinked_SNPs/10X/10x_TOA_only_filtered_unlinked_SNPs_all_pcangsd_1

#unlinked SNPs filtered using bcftools output based on no_repeats_depthfilter_noDS_TOA_only_bam.filelist, no downsampling (n=41)
#pcangsd -p /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/20_bcftools/noDS/02_all_SNPs/02_unlinked_SNPs/noDS_TOA_only_filtered_SNPs_all_unlinked -t 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/19_PCAngsd/02_genotypes/01_all_SNPs/02_unlinked_SNPs/noDS/noDS_TOA_only_filtered_unlinked_SNPs_all_pcangsd_1

### Unlinked neutral SNP datasets, based on pcadapt outlier detection, including only TOA samples

#unlinked SNPs filtered using bcftools output based on no_repeats_depthfilter_DS2x_TOA_only_bam.filelist, downsampled to 2x (n=37)
#pcangsd -p /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/20_bcftools/2X/03_neutral_SNPs/02_unlinked_neutral_SNPs/2x_TOA_only_filtered_SNPs_unlinked_Neutral -t 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/19_PCAngsd/02_genotypes/02_neutral_SNPs/02_unlinked_SNPs/2X/2x_TOA_only_filtered_unlinked_SNPs_Neutral_pcangsd_1

#unlinked SNPs filtered using bcftools output based on no_repeats_depthfilter_DS5x_TOA_only_bam.filelist, downsampled to 5x (n=24)
#pcangsd -p /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/20_bcftools/5X/03_neutral_SNPs/02_unlinked_neutral_SNPs/5x_TOA_only_filtered_SNPs_unlinked_Neutral -t 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/19_PCAngsd/02_genotypes/02_neutral_SNPs/02_unlinked_SNPs/5X/5x_TOA_only_filtered_unlinked_SNPs_Neutral_pcangsd_1

#unlinked SNPs filtered using bcftools output based on no_repeats_depthfilter_DS10x_TOA_only_bam.filelist, downsampled to 10x (n=14)
#pcangsd -p /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/20_bcftools/10X/03_neutral_SNPs/02_unlinked_neutral_SNPs/10x_TOA_only_filtered_SNPs_unlinked_Neutral -t 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/19_PCAngsd/02_genotypes/02_neutral_SNPs/02_unlinked_SNPs/10X/10x_TOA_only_filtered_unlinked_SNPs_Neutral_pcangsd_1

#unlinked SNPs filtered using bcftools output based on no_repeats_depthfilter_noDS_TOA_only_bam.filelist, no downsampling (n=41)
#pcangsd -p /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/20_bcftools/noDS/03_neutral_SNPs/02_unlinked_neutral_SNPs/noDS_TOA_only_filtered_SNPs_unlinked_Neutral -t 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/19_PCAngsd/02_genotypes/02_neutral_SNPs/02_unlinked_SNPs/noDS/noDS_TOA_only_filtered_unlinked_SNPs_Neutral_pcangsd_1

### Unlinked adaptive SNP datasets, based on pcadapt outlier detection, including only TOA samples

#unlinked SNPs filtered using bcftools output based on no_repeats_depthfilter_DS2x_TOA_only_bam.filelist, downsampled to 2x (n=37)
#pcangsd -p /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/20_bcftools/2X/04_adaptive_SNPs/02_unlinked_adaptive_SNPs/2x_TOA_only_filtered_SNPs_unlinked_Adaptive -t 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/19_PCAngsd/02_genotypes/03_adaptive_SNPs/02_unlinked_SNPs/2X/2x_TOA_only_filtered_unlinked_SNPs_Adaptive_pcangsd_1

#unlinked SNPs filtered using bcftools output based on no_repeats_depthfilter_DS5x_TOA_only_bam.filelist, downsampled to 5x (n=24)
#pcangsd -p /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/20_bcftools/5X/04_adaptive_SNPs/02_unlinked_adaptive_SNPs/5x_TOA_only_filtered_SNPs_unlinked_Adaptive -t 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/19_PCAngsd/02_genotypes/03_adaptive_SNPs/02_unlinked_SNPs/5X/5x_TOA_only_filtered_unlinked_SNPs_Adaptive_pcangsd_1

#unlinked SNPs filtered using bcftools output based on no_repeats_depthfilter_DS10x_TOA_only_bam.filelist, downsampled to 10x (n=14)
#pcangsd -p /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/20_bcftools/10X/04_adaptive_SNPs/02_unlinked_adaptive_SNPs/10x_TOA_only_filtered_SNPs_unlinked_Adaptive -t 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/19_PCAngsd/02_genotypes/03_adaptive_SNPs/02_unlinked_SNPs/10X/10x_TOA_only_filtered_unlinked_SNPs_Adaptive_pcangsd_1

#unlinked SNPs filtered using bcftools output based on no_repeats_depthfilter_noDS_TOA_only_bam.filelist, no downsampling (n=41)
#pcangsd -p /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/20_bcftools/noDS/04_adaptive_SNPs/02_unlinked_adaptive_SNPs/noDS_TOA_only_filtered_SNPs_unlinked_Adaptive -t 40 -o /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/19_PCAngsd/02_genotypes/03_adaptive_SNPs/02_unlinked_SNPs/noDS/noDS_TOA_only_filtered_unlinked_SNPs_Adaptive_pcangsd_1
