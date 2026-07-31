#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=concat_merged_unmerged_four_laned_individuals
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=12
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-180
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/read_alignment/logs/concat_merged_unmerged_four_laned_individuals/%j.out

# define main working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data

basename_array=$( head -n${SLURM_ARRAY_TASK_ID} basenames_four_lanes.txt | tail -n1 )

# load samtools/1.20 module
module load samtools/1.20

# combine the two bam files
samtools cat ${workdir}/00_bam_files/${basename_array}_merged_combined_rmdup.bam \
${workdir}/00_bam_files/${basename_array}_unmerged_combined_mate_fixed_realign_sorted.bam > ${workdir}/00_bam_files/${basename_array}_pre_indel_realign.bam
