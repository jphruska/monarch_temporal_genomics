#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=angsd_het_saf_file_final_no_trans_downsampled
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=4
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-171
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/heterozygosity/logs/angsd_2x_het_create_saf_file_final_no_trans_downsampled/%j.out

# define reference genome/location
ref=/work/sonsthagen/johruska/monarchs/reference_genome/GCF_018135715.1_MEX_DaPlex_genomic.fna

# define working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data

# define angsd directory to v 0.940
angsd_dir=/home/sonsthagen/johruska/.conda/envs/angsdv0.940/bin/

# define bam
bam=$(head -n ${SLURM_ARRAY_TASK_ID} bam_list_2x_final_downsampled.txt | tail -n 1)

# define individual
indiv=$(head -n ${SLURM_ARRAY_TASK_ID} 2x_individuals_basenames_final.txt | tail -n 1)

# run angsd
${angsd_dir}/angsd -i ${bam} \
-anc ${ref} \
-ref ${ref} \
-rf ./regions.txt \
-out ${workdir}/07_het_angsd_winsfs_2x_final_no_trans_downsampled/${indiv}.saf \
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
