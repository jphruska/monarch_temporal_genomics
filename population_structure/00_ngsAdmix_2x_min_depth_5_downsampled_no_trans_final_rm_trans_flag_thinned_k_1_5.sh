#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=ngsadmix_2x_mindepth_5_downsampled_no_trans_rm_trans_flag_thinned_final_k_1_5
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=8
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/pop_structure/logs/ngsadmix_angsd_2x_latest_mindepth_5_downsampled_no_trans_rm_trans_flag_thinned_final_k_1_5/%j.out

workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data

# K of 2 
/home/sonsthagen/johruska/NGSadmix/NGSadmix \
-likes ${workdir}/03_angsd_gls_2/2x_cov_final_mindepth_5_downsampled_no_trans_rm_trans_flag_thinned.beagle.gz \
-K 2 \
-outfiles ${workdir}/04_ngsadmix_angsd_2x_final/ngsAdmix_k2_rm_trans_flag_final_thinned \
-P 8 \

# K of 3 
/home/sonsthagen/johruska/NGSadmix/NGSadmix \
-likes ${workdir}/03_angsd_gls_2/2x_cov_final_mindepth_5_downsampled_no_trans_rm_trans_flag_thinned.beagle.gz \
-K 3 \
-outfiles ${workdir}/04_ngsadmix_angsd_2x_final/ngsAdmix_k3_rm_trans_flag_final_thinned \
-P 8 \

# K of 4 
/home/sonsthagen/johruska/NGSadmix/NGSadmix \
-likes ${workdir}/03_angsd_gls_2/2x_cov_final_mindepth_5_downsampled_no_trans_rm_trans_flag_thinned.beagle.gz \
-K 4 \
-outfiles ${workdir}/04_ngsadmix_angsd_2x_final/ngsAdmix_k4_rm_trans_flag_final_thinned \
-P 8 \

# K of 5 
/home/sonsthagen/johruska/NGSadmix/NGSadmix \
-likes ${workdir}/03_angsd_gls_2/2x_cov_final_mindepth_5_downsampled_no_trans_rm_trans_flag_thinned.beagle.gz \
-K 5 \
-outfiles ${workdir}/04_ngsadmix_angsd_2x_final/ngsAdmix_k5_rm_trans_flag_final_thinned \
-P 8
