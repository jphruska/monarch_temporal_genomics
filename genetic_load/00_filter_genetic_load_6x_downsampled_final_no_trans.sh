#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=genetic_load_6x_downsampled_final_no_transitions_filtering
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --partition=batch
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-22
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/genetic_load/logs/6x_downsampled_final_no_transitions_filtering/%j.out

module load vcftools/0.1

# define main working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data

# scaffold list 
region_array=$( head -n${SLURM_ARRAY_TASK_ID} monarch_ref_genome_chromosomes_no_z_gcf.txt | tail -n1 )

# filter vcfs 
vcftools --vcf ${workdir}/03_vcf_6x_final_downsampled/${region_array}_notrans.vcf \
--remove-indels \
--out ${workdir}/13_load_6x_downsampled_no_transitions_final/6x_downsampled_no_transitions_load_${region_array} \
--minDP 4 \
--max-maf 0.49 \
--max-alleles 2 \
--min-alleles 2 \
--mac 2 \
--recode \
--recode-INFO-all \
--max-missing 1
