#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=pcangsd_2x_mindepth_5_downsampled_no_trans_final_rmTrans_flag_thinned
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=8
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/pop_structure/logs/pca_angsd_2x_latest_mindepth_5_downsampled_no_trans_final_rmTrans_flag_thinned/%j.out

workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data

/home/sonsthagen/johruska/.conda/envs/pcangsd/bin/pcangsd \
-b ${workdir}/03_angsd_gls_2/2x_cov_final_mindepth_5_downsampled_no_trans_rm_trans_flag_thinned.beagle.gz \
-o ${workdir}/04_pca_angsd_2x_final/2x_cov_final_mindepth_5_downsampled_no_trans_rm_trans_flag_thinned_pcangsd \
--geno 0.1 \
--threads 8
