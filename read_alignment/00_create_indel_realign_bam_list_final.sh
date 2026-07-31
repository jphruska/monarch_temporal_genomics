#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=monarch_indel_bamlist_target_creator_final
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=1
#SBATCH --time=1:00:00
#SBATCH --mem-per-cpu=1G
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/read_alignment/logs/indel_bamlist_target_creator_final/%j.out


for i in `cat final_data_indiv_list.txt` ; do echo /work/sonsthagen/johruska/monarchs/sequence_data/data/00_bam_files_final/${i}_pre_indel_realign_sorted.bam >> indel_realign_bam_list_final.list ; done
