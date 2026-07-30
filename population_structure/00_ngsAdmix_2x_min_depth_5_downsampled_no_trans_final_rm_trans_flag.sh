#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=ngsadmix_2x_mindepth_5_downsampled_no_trans_rm_trans_flag_final
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=8
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/pop_structure/logs/ngsadmix_angsd_2x_latest_mindepth_5_downsampled_no_trans_rm_trans_flag_final/%j.out

workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data

# K of 2 
/home/sonsthagen/johruska/NGSadmix/NGSadmix \
-likes ${workdir}/03_angsd_gls_2/2x_cov_final_mindepth_5_downsampled_no_trans_rm_trans_flag.beagle.gz \
-K 2 \
-o ${workdir}/04_ngsadmix_angsd_2x_final/ngsAdmix_k2_rm_trans_flag_final \
-P 8 \

# K of 3 
/home/sonsthagen/johruska/NGSadmix/NGSadmix \
-likes ${workdir}/03_angsd_gls_2/2x_cov_final_mindepth_5_downsampled_no_trans_rm_trans_flag.beagle.gz \
-K 3 \
-o ${workdir}/04_ngsadmix_angsd_2x_final/ngsAdmix_k3_rm_trans_flag_final \
-P 8 \

# K of 4 
/home/sonsthagen/johruska/NGSadmix/NGSadmix \
-likes ${workdir}/03_angsd_gls_2/2x_cov_final_mindepth_5_downsampled_no_trans_rm_trans_flag.beagle.gz \
-K 4 \
-o ${workdir}/04_ngsadmix_angsd_2x_final/ngsAdmix_k4_rm_trans_flag_final \
-P 8 \

# K of 5 
/home/sonsthagen/johruska/NGSadmix/NGSadmix \
-likes ${workdir}/03_angsd_gls_2/2x_cov_final_mindepth_5_downsampled_no_trans_rm_trans_flag.beagle.gz \
-K 5
-o ${workdir}/04_ngsadmix_angsd_2x_final/ngsAdmix_k5_rm_trans_flag_final \
-P 8 \

# K of 6 
/home/sonsthagen/johruska/NGSadmix/NGSadmix \
-likes ${workdir}/03_angsd_gls_2/2x_cov_final_mindepth_5_downsampled_no_trans_rm_trans_flag.beagle.gz \
-K 6 \
-o ${workdir}/04_ngsadmix_angsd_2x_final/ngsAdmix_k6_rm_trans_flag_final \
-P 8 \

# K of 7
/home/sonsthagen/johruska/NGSadmix/NGSadmix \
-likes ${workdir}/03_angsd_gls_2/2x_cov_final_mindepth_5_downsampled_no_trans_rm_trans_flag.beagle.gz \
-K 7 \ 
-o ${workdir}/04_ngsadmix_angsd_2x_final/ngsAdmix_k7_rm_trans_flag_final \
-P 8 \

# K of 8 
/home/sonsthagen/johruska/NGSadmix/NGSadmix \
-likes ${workdir}/03_angsd_gls_2/2x_cov_final_mindepth_5_downsampled_no_trans_rm_trans_flag.beagle.gz \
-K 8 \
-o ${workdir}/04_ngsadmix_angsd_2x_final/ngsAdmix_k8_rm_trans_flag_final \
-P 8 \

# K of 9 
/home/sonsthagen/johruska/NGSadmix/NGSadmix \
-likes ${workdir}/03_angsd_gls_2/2x_cov_final_mindepth_5_downsampled_no_trans_rm_trans_flag.beagle.gz \
-K 9 \ 
-o ${workdir}/04_ngsadmix_angsd_2x_final/ngsAdmix_k9_rm_trans_flag_final \
-P 8 \

# K of 10
/home/sonsthagen/johruska/NGSadmix/NGSadmix \
-likes ${workdir}/03_angsd_gls_2/2x_cov_final_mindepth_5_downsampled_no_trans_rm_trans_flag.beagle.gz \
-K 10 \ 
-o ${workdir}/04_ngsadmix_angsd_2x_final/ngsAdmix_k10_rm_trans_flag_final \
-P 8 \
