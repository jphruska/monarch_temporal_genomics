# Temporal Genomics of the Monarch Butterfly (Danaus plexippus)
Documenting genetic changes over 123 year period. 

### Descriptions of folder contents

#### prep_reference
1) Create indices of reference genome (GCF_018135715.1_MEX_DaPlex_genomic.fna) with samtools faidx and bwa index.
2) Create dictionary for GATK with CreateSequenceDictionary.

#### read_processing
1) Scripts involved in read trimming, poly-G tail removal with BBMap.
2) Read merging and adapter removal with SeqPrep2.
3) Removing low complexity reads with nf-polish.

#### read_alignment
1) Alignment of merged and unmerged reads with bwa aln.
2) Clip overlaps of unmerged reads with bamUtil clipOverlap. 
3) Indel realignment with GATK.
4) Alignment downsampling with samtools view.
5) Alignment stats with samtools flagstat and samtools depth. 

#### genotyping
1) Genotyping and filtering of high coverage temporal dataset (n=55, depth of coverage > 6x) with bcftools mpileup, view, +fill-tags, +setGT, per individual. Removal of transition variants with awk one liner. 
2) Merging of per-individual VCFs into one with bcftools merge -m id.
3) Genotyping high coverage 2023-2024 individuals (n=36, depth of coverage > 6x) for GONE (recent Ne analyses) in a similar fashion, with the exception being that transition variants are now retained. 

#### genotype_likelihoods
1) Cacluate genotype likelihoods with ANGSD for per-individual heterozygosity, nucleotide diversity, genetic differentiation, and population structure. 

#### effective_population_size
1) Combine per-chromosome VCFs into one VCF with bcftools concat. 

#### genetic differentiation
1) Pairwise time period FST calculation with winsfs view, realSFS fst index + stats.

#### genetic_diversity_pi
1) Nucleotide diversity of 9 randomly sampled individuals per period, calculated with realSFS saf2theta and thetaStat do_stat.

#### genetic_load
1) Calculated genetic load with snpEff. 

#### roh
1) Identify ROH in individuals with bcftools roh. 

#### figures
1) R scripts to make Figures 1-5 and Supplemental Figures. 
