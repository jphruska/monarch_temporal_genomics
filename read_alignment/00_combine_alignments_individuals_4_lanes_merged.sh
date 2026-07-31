#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=monarch_combined_alignments_individuals_4_lanes_merged
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=12
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-180
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/read_alignment/logs/combining_4_lanes_merged/%j.out

# define main working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data

basename_array=$( head -n${SLURM_ARRAY_TASK_ID} basenames_four_lanes.txt | tail -n1 )

# load samtools/1.20 module
module load samtools/1.20

# merge BAM files for individuals sequenced across four lanes 
samtools merge ${workdir}/00_bam_files/${basename_array}_A_merged_cleaned_sorted_rg.bam \
${workdir}/00_bam_files/${basename_array}_B_merged_cleaned_sorted_rg.bam \
${workdir}/00_bam_files/${basename_array}_C_merged_cleaned_sorted_rg.bam \
${workdir}/00_bam_files/${basename_array}_D_merged_cleaned_sorted_rg.bam \
-o ${workdir}/00_bam_files/${basename_array}_merged_combined.bam

# index the combined file
samtools index ${workdir}/00_bam_files/${basename_array}_merged_combined.bam
