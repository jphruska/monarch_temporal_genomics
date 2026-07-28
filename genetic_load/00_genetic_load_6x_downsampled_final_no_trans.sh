#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=6x_downsampled_final_no_transitions_snpeff_load
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --partition=batch
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-22
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/genetic_load/logs/6x_downsampled_final_no_transitions_snpeff_load/%j.out

# define main working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data

# scaffold list 
region_array=$( head -n${SLURM_ARRAY_TASK_ID} ./monarch_ref_genome_chromosomes_no_z_gcf.txt | tail -n1 )
 
# load snpEff module
module load snpeff/4.3
 
# run snpEff per chromosome 
java -Xmx32g -jar /util/opt/anaconda/deployed-conda-envs/packages/snpeff/envs/snpeff-4.3.1t/share/snpeff-4.3.1t-1/snpEff.jar \
GCF_018135715.1_MEX_DaPlex_genomic \
-stats ${workdir}/13_load_6x_downsampled_no_transitions_final/${region_array} \
${workdir}/13_load_6x_downsampled_no_transitions_final/6x_downsampled_no_transitions_load_${region_array}.recode.vcf \
> ${workdir}/13_load_6x_downsampled_no_transitions_final/6x_downsampled_no_transitions_load_${region_array}.ann.vcf

# keep only changes with low, moderate, or high impact
grep '|LOW|\||MODERATE|\||HIGH|' ${workdir}/13_load_6x_downsampled_no_transitions_final/6x_downsampled_no_transitions_load_${region_array}.ann.vcf \
> ${workdir}/13_load_6x_downsampled_no_transitions_final/6x_downsampled_no_transitions_load_${region_array}.ann2.vcf

