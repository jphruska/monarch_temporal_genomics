#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=fastqc_trimmed_unmerged_final
#SBATCH --partition batch
#SBATCH --time=24:00:00
#SBATCH --nodes=1 --ntasks=6
#SBATCH --mem-per-cpu=5GB
#SBATCH --array=1-790
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/read_processing/logs/fastqc_trimmed_unmerged_final/%j.out

module load fastqc # default version is v0.12.1

basename_array=$(head -n ${SLURM_ARRAY_TASK_ID} ./combined_basenames_final.txt | tail -n1)

# define fastq input directory 
fastqdir=/work/sonsthagen/johruska/monarchs/sequence_data/data/00_trimmed

fastqc -o ./fastqc_reports_trimmed_unmerged_final -t 6 ${fastqdir}/${basename_array}_R1.fastq.gz ${fastqdir}/${basename_array}_R2.fastq.gz
