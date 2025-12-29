input="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/22_bayescan/2X/03_bayescan_run_3/2x_unlinked_TOA_only_filtered_SNPs_all.geste_bayescan.txt"
output="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/22_bayescan/2X/03_bayescan_run_3/2x_unlinked_bayescan_run_1"

/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/x_scripts/BayeScan2.1/source/bayescan_2.1 $input -o $output -n 5000 -thin 10 -nbp 20 -pilot 5000 -burn 50000 -pr_odds 10 -threads 20 -all_trace

# benestan tutorial code
#/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/02_WG/x_scripts/BayeScan2.1/source/bayescan_2.1 $input -o $output -n 5000 -burn 50000 -pr_odds 10000
