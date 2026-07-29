#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=angsd_2x_pi_1996_2003_saf_file_no_trans_downsampled_final_even
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=4
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/genetic_diversity_pi/logs/genetic_diversity_pi_saf_file_no_trans_1996_2003_downsampled_final_even/%j.out

# define reference genome/location
ref=/work/sonsthagen/johruska/monarchs/reference_genome/GCF_018135715.1_MEX_DaPlex_genomic.fna

# define working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data

# define angsd directory to v 0.940
angsd_dir=/home/sonsthagen/johruska/.conda/envs/angsdv0.940/bin/

# run angsd
${angsd_dir}/angsd -b bam_list_2x_1996_2003_downsampled_final_even.txt \
-anc ${ref} \
-ref ${ref} \
-rf ./regions.txt \
-out ${workdir}/07_diversity_pi_1996_2003_no_trans_downsampled_final_even/2x_1996_2003.saf \
-minMapQ 30 \
-minQ 30 \
-doSaf 1 \
-baq 0 \
-setMinDepth 5 \
-GL 1 \
-doGlf 2 \
-noTrans 1 \
-doMajorMinor 1 \
-skipTriallelic 1 \
-doCounts 1 \
-P 4 \
-remove_bads 1 \
-uniqueOnly 1
