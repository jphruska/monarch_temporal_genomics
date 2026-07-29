#!/bin/sh
#SBATCH --chdir=./
#SBATCH --job-name=combined_currentne_gone2_filter_effective_pop_size
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --partition=batch
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-22
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/effective_population_size/logs/combined_currentne_gone_filter_effective_pop_size/%j.out

module load vcftools/0.1

# define main working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data

# scaffold list 
region_array=$(head -n${SLURM_ARRAY_TASK_ID} monarch_ref_genome_chromosomes_no_z_gcf.txt | tail -n1 )

# filter for currentNe and GONE (will use same input)
vcftools --vcf ${workdir}/03_vcf_6x_final/${region_array}.vcf \
--max-missing 1.0 \
--min-alleles 2 \
--max-alleles 2 \
--maxDP 100 \
--recode --recode-INFO-all --out ${workdir}/15_currentNe2_6x_final/combined/combined_${region_array}

# scp vcfs to GONE directory 
scp ${workdir}/15_currentNe2_6x_final/combined/combined_${region_array}.vcf ${workdir}/15_gone2_6x_final/combined/

