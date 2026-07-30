#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=monarch_run_finestructure_step_4_full
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=10
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=80G
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/pop_structure/logs/monarch_run_finestructure_step_4_full/%j.out

workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full 

source activate finestructure

module load gnu-parallel/20220722

cat ${workdir}/monarch_finestructure/commandfiles/commandfile2.txt | parallel
