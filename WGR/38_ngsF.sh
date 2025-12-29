#!/bin/bash

#N_SITES_5x=$((`zcat /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/16_ngsRelate/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf3_minMaf0.05_SNPpval1e6_minInd18_NR_depth_DS5X.mafs.gz | wc -l`-1))
#N_SITES_2x=$((`zcat /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/16_ngsRelate/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf3_minMaf0.05_SNPpval1e6_minInd29_NR_depth_DS2X.mafs.gz | wc -l`-1))
#N_SITES_10x=$((`zcat /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/16_ngsRelate/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf3_minMaf0.05_SNPpval1e6_minInd11_NR_depth_DS10X.mafs.gz | wc -l`-1))
N_SITES_noDS=$((`zcat /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/16_ngsRelate/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf3_minMaf0.05_SNPpval1e6_minInd32_NR_depth.mafs.gz | wc -l`-1))

#ESTIMATE INBREEDING COEFFICIENTS BY RUNNING 10 REPLICATES TO PREVENT CONVERGENCE TO LOCAL MAXIMA (ngsF)

### 5x
#1st: Initial run to get approximate values
#/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/x_scripts/ngsF/ngsF --n_ind 25 --n_sites $N_SITES_5x --glf /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/16_ngsRelate/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf3_minMaf0.05_SNPpval1e6_minInd18_NR_depth_DS5X.glf --min_epsilon 1e-05  --out /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/16_ngsRelate/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf3_minMaf0.05_SNPpval1e6_minInd18_NR_depth_DS5X_indF --approx_EM --seed 12345 --init_values r

#2nd: Final run using the initial values as priors
#/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/x_scripts/ngsF/ngsF --glf /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/16_ngsRelate/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf3_minMaf0.05_SNPpval1e6_minInd18_NR_depth_DS5X.glf --n_ind 25 --n_sites $N_SITES_5x --min_epsilon 1e-07 --out /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/16_ngsRelate/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf3_minMaf0.05_SNPpval1e6_minInd18_NR_depth_DS5X_vcf_reps.indF --init_values /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/16_ngsRelate/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf3_minMaf0.05_SNPpval1e6_minInd18_NR_depth_DS5X_indF.pars --n_threads 40

### 2x
#1st: Initial run to get approximate values
#/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/x_scripts/ngsF/ngsF --n_ind 39 --n_sites $N_SITES_2x --glf /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/16_ngsRelate/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf3_minMaf0.05_SNPpval1e6_minInd29_NR_depth_DS2X.glf --min_epsilon 1e-05  --out /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/16_ngsRelate/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf3_minMaf0.05_SNPpval1e6_minInd29_NR_depth_DS2X_indF --approx_EM --seed 12345 --init_values r

#2nd: Final run using the initial values as priors
#/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/x_scripts/ngsF/ngsF --glf /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/16_ngsRelate/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf3_minMaf0.05_SNPpval1e6_minInd29_NR_depth_DS2X.glf --n_ind 39 --n_sites $N_SITES_2x --min_epsilon 1e-07 --out /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/16_ngsRelate/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf3_minMaf0.05_SNPpval1e6_minInd29_NR_depth_DS2X_vcf_reps.indF --init_values /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/16_ngsRelate/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf3_minMaf0.05_SNPpval1e6_minInd29_NR_depth_DS2X_indF.pars --n_threads 40

### 10x
#1st: Initial run to get approximate values
#/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/x_scripts/ngsF/ngsF --n_ind 15 --n_sites $N_SITES_10x --glf /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/16_ngsRelate/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf3_minMaf0.05_SNPpval1e6_minInd11_NR_depth_DS10X.glf --min_epsilon 1e-05  --out /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/16_ngsRelate/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf3_minMaf0.05_SNPpval1e6_minInd11_NR_depth_DS10X_indF --approx_EM --seed 12345 --init_values r

#2nd: Final run using the initial values as priors
#/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/x_scripts/ngsF/ngsF --glf /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/16_ngsRelate/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf3_minMaf0.05_SNPpval1e6_minInd11_NR_depth_DS10X.glf --n_ind 15 --n_sites $N_SITES_10x --min_epsilon 1e-07 --out /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/16_ngsRelate/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf3_minMaf0.05_SNPpval1e6_minInd11_NR_depth_DS10X_vcf_reps.indF --init_values /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/16_ngsRelate/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf3_minMaf0.05_SNPpval1e6_minInd11_NR_depth_DS10X_indF.pars --n_threads 40

### noDS
#1st: Initial run to get approximate values
#/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/x_scripts/ngsF/ngsF --n_ind 43 --n_sites $N_SITES_noDS --glf /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/16_ngsRelate/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf3_minMaf0.05_SNPpval1e6_minInd32_NR_depth.glf --min_epsilon 1e-06  --out /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/16_ngsRelate/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf3_minMaf0.05_SNPpval1e6_minInd32_NR_depth_noDS_indF --approx_EM --seed 12345 --init_values r

#2nd: Final run using the initial values as priors
/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/x_scripts/ngsF/ngsF --glf /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/16_ngsRelate/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf3_minMaf0.05_SNPpval1e6_minInd32_NR_depth.glf --n_ind 43 --n_sites $N_SITES_noDS --min_epsilon 1e-07 --out /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/16_ngsRelate/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf3_minMaf0.05_SNPpval1e6_minInd32_NR_depth_noDS_vcf_reps.indF --init_values /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/16_ngsRelate/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf3_minMaf0.05_SNPpval1e6_minInd32_NR_depth_noDS_indF.pars --n_threads 40
