# Temporal Genomics of the Monarch Butterfly (Danaus plexippus)
Documenting genetic changes over 123 year period. 

Directory Information:
# prep reference
1) Create indices of reference genome (GCF_018135715.1_MEX_DaPlex_genomic.fna) with samtools faidx and bwa index.
2) Create dictionary for GATK with CreateSequenceDictionary.

# read_processing
1) Scripts involved in read trimming, adapter removal, poly-G tail removal with BBMap.
2) Read merging with SeqPrep2.
3) Removing low complexity reads with nf-polish.

# read alignment
1) Alignment of merged and unmerged reads with bwa aln.
2) 
3) Indel realignment with GATK.
4) Alignment downsampling with samtools view.
5) Alignment stats with samtools flagstat and samtools depth. 
