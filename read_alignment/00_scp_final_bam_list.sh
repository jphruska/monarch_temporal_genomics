#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=scp_final_list_bams
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=1
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-250
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/read_alignment/logs/scp_final_list_bams/%j.out

# define individual
indiv=$(head -n ${SLURM_ARRAY_TASK_ID} final_data_indiv_list.txt | tail -n 1)

#define workdir
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data

scp ${workdir}/00_bam_files/${indiv}_pre_indel_realign_sorted.bam ${workdir}/00_bam_files_final
