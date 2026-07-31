#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=combined_merged_alignments_duplicate_removal
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=12
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-180
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/read_alignment/logs/combined_merged_dup_removal/%j.out

# define main working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data

basename_array=$( head -n${SLURM_ARRAY_TASK_ID} basenames_four_lanes.txt | tail -n1 )

# load dedup v0.12.9
source activate dedup

dedup \
-i ${workdir}/00_bam_files/${basename_array}_merged_combined.bam \
-m \
-u \
-o ${workdir}/00_bam_files
