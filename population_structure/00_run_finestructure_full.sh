#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=monarch_run_finestructure 
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=10
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=80G
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/pop_structure/logs/monarch_run_finestructure/%j.out

source activate finestructure

fs /work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_finestructure.cp -idfile /work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/6x_downsampled_final_ids.txt \
-phasefiles /work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083537.1_chromo.phase \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083538.1_chromo.phase \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083539.1_chromo.phase \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083540.1_chromo.phase \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083541.1_chromo.phase \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083542.1_chromo.phase \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083543.1_chromo.phase \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083544.1_chromo.phase \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083545.1_chromo.phase \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083546.1_chromo.phase \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083547.1_chromo.phase \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083548.1_chromo.phase \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083549.1_chromo.phase \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083550.1_chromo.phase \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083551.1_chromo.phase \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083552.1_chromo.phase \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083553.1_chromo.phase \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083554.1_chromo.phase \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083555.1_chromo.phase \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083556.1_chromo.phase \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083557.1_chromo.phase \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083558.1_chromo.phase \
-recombfiles /work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083537.1_chromo.rec \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083538.1_chromo.rec \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083539.1_chromo.rec \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083540.1_chromo.rec \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083541.1_chromo.rec \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083542.1_chromo.rec \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083543.1_chromo.rec \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083544.1_chromo.rec \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083545.1_chromo.rec \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083546.1_chromo.rec \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083547.1_chromo.rec \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083548.1_chromo.rec \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083549.1_chromo.rec \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083550.1_chromo.rec \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083551.1_chromo.rec \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083552.1_chromo.rec \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083553.1_chromo.rec \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083554.1_chromo.rec \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083555.1_chromo.rec \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083556.1_chromo.rec \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083557.1_chromo.rec \
/work/sonsthagen/johruska/monarchs/sequence_data/data/04_fine_structure_full/monarch_phased_NC.083558.1_chromo.rec \
-Neinf 1000000 \
-hpc 1 \
-go
