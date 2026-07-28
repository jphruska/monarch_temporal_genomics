#!/bin/sh
#SBATCH --chdir=./
#SBATCH --job-name=monarch_6x_merge_genotypes_final_b
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --partition=batch
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/genotyping/logs/bcftools_genotype_6x_subsampled_final_b/%j.out
#SBATCH --array=1-23

module load bcftools/1.21

# define main working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data

# scaffold variable
region_array=$( head -n${SLURM_ARRAY_TASK_ID} monarch_ref_genome_chromosomes_no_z_gcf.txt | tail -n1 )

# run bcftools to merge the vcf files (transitions included)
bcftools merge -m id --regions ${region_array} ${workdir}/02_vcf_6x_final_downsampled/*_trans.vcf.gz > ${workdir}/03_vcf_6x_final_downsampled/${region_array}_trans.vcf

# run bcftools to merge the vcf files (transitions excluded) 
bcftools merge -m id --regions ${region_array} ${workdir}/02_vcf_6x_final_downsampled/*_notrans.vcf.gz > ${workdir}/03_vcf_6x_final_downsampled/${region_array}_notrans.vcf
