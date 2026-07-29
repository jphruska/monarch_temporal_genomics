#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=combined_gone
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --partition=batch
#SBATCH --time=6:00:00
#SBATCH --mem-per-cpu=4G


./script_GONE.sh combined_currentne_gone_final_2
