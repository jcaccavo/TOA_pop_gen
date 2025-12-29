#!/bin/bash

N_SITES=$((`zcat /srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/16_ngsRelate/dmawsoni2021_GL1_doMaf3_doMajorMinor1_doGlf3_minMaf0.05_SNPpval1e6_minInd18_NR_depth_DS5X.mafs.gz | wc -l`-1))

#ESTIMATE INBREEDING COEFFICIENTS BY RUNNING 10 REPLICATES TO PREVENT CONVERGENCE TO LOCAL MAXIMA (ngsF)

#1st: Initial run to get approximate values
.../ngsF --n_ind 25 --n_sites $N_SITES_5x --glf .../FILENAME.glf --min_epsilon 1e-05  --out .../FILENAME_indF --approx_EM --seed 12345 --init_values r

#2nd: Final run using the initial values as priors
.../ngsF --glf .../FILENAME.glf --n_ind 25 --n_sites $N_SITES_5x --min_epsilon 1e-07 --out .../FILENAME_reps.indF --init_values .../FILENAME_indF.pars --n_threads 40
