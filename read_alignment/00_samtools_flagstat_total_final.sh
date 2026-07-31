#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=monarch_flagstat_alignment_stats_total_final
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=1
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-250
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/read_alignment/logs/samtools_flagstat_total_final/%j.out

module purge
module load samtools/1.20

# define main working directory
workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data/00_bam_files_final

# define output base directory
output_dir=/work/sonsthagen/johruska/monarchs/scripts/read_alignment/flagstat_total_final

# define array of sequencing ID basenames for total dataset
basename_array=$( head -n${SLURM_ARRAY_TASK_ID} final_data_indiv_list.txt | tail -n1 )


samtools flagstat ${workdir}/${basename_array}_pre_indel_realign_sorted_realigned_final.bam > ${output_dir}/${basename_array%_final.bam}_flagstat.txt
