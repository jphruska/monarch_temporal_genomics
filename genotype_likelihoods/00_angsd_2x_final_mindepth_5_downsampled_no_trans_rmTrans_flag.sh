#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=angsd_2x_gl_final_mindepth_5_downsampled_no_trans_rmTrans_flag
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=4
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=20G
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/genotype_likelihoods/logs/angsd_2x_final_mindepth_5_downsampled_no_trans_rmTrans_flag/%j.out

# define reference genome/location
ref=/work/sonsthagen/johruska/monarchs/reference_genome/GCF_018135715.1_MEX_DaPlex_genomic.fna

# define working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data/

angsd_dir=/home/sonsthagen/johruska/.conda/envs/angsdv0.940/bin/

# run angsd
${angsd_dir}/angsd -b ./bam_list_2x_final_downsampled.txt \
-anc ${ref} \
-rf ./regions.txt \
-out ${workdir}/03_angsd_gls_2/2x_cov_final_mindepth_5_downsampled_no_trans_rm_trans_flag \
-minMapQ 30 \
-minQ 30 \
-doMaf 1 \
-minMaf 0.05 \
-baq 0 \
-setMinDepth 5 \
-SNP_pval 2e-6 \
-GL 1 \
-doGlf 2 \
-rmTrans 1 \
-doMajorMinor 1 \
-skipTriallelic 1 \
-doPost 1 \
-doIBS 1 \
-doCounts 1 \
-doCov 1 \
-makeMatrix 1 \
-P 4 \
-remove_bads 1 \
-uniqueOnly 1
