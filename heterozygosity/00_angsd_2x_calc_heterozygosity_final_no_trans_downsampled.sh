#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=angsd_2x_calc_heterozygosity_final_no_trans_downsampled
#SBATCH --partition batch
#SBATCH --nodes=1 --ntasks=1
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH -o /work/sonsthagen/johruska/monarchs/scripts/heterozygosity/logs/angsd_2x_calc_het_final_no_trans_downsampled/%j.out


workdir=/work/sonsthagen/johruska/monarchs/sequence_data/data/07_het_angsd_winsfs_2x_final_no_trans_downsampled/

for i in `ls /work/sonsthagen/johruska/monarchs/sequence_data/data/07_het_angsd_winsfs_2x_final_no_trans_downsampled/*.idx` ; \
do basename=$(basename $i .saf.saf.idx) ; \ 
winsfs ${workdir}/${basename}.saf.saf.idx > ${workdir}/${basename}.saf.saf.sfs ; \
winsfs view -f ${workdir}/${basename}.saf.saf.sfs > ${workdir}/${basename}.saf.saf.sfs.folded ; \
var1=$(cat ${workdir}/${basename}.saf.saf.sfs.folded | tail -n 1 | cut -d ' ' -f 1) ; \
var2=$(cat ${workdir}/${basename}.saf.saf.sfs.folded | tail -n 1 | cut -d ' ' -f 2) ; \
var3=$(awk -v var1=$var1 -v var2=$var2 'BEGIN { print var1 + var2}') ; \
het=$(awk -v var2=$var2 -v var3=$var3 'BEGIN { print (var2/var3)}') ; \
echo $basename $het >> ${workdir}/het.txt ; \
done 

 


