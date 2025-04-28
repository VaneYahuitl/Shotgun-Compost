# Shotgun-Compost
Análisis de datos de secuenciación por Shotgun a partir de muestras de composta de estiercol de vaca:

1.Preprocessing data:
Raw reads were mapped against the masked human reference genome GRCh38.p14 and the cow reference genome ARS-UCD1.3 using BBMap (https://sourceforge.net/projects/bbmap/). 

Unmapped reads to the human genome were trimmed using Trimommatic with an average Q-score < 20 and shorter than 50 nucleotides were discarded.

2.Taxonomy Read-Based:
High quality reads were used as inputs for the MEGAHIT assembler (Li et al., 2015). 
(--k-min 27 –k-max 127 and --k-step 10).
The minimum contig length was set to 500 nt.

3.Protein annotation was done with Prokka v. 1.13 using the metagenome setting for highly fragmented datasets (https://github.com/tseemann/prokka) (Seeman, 2014).

To quantify the genes, we used bowtie2 v. 2.5.3 (Langmead and Salzber, 2012) and quantified with HTSeq v. 2.0.3 (Anders et al., 2015). 

4. Metabolic pathways

The generic feature annotation file (GFF Prokka's annotation output) was filtered to retain all genes with a KO identifier assigned.
The "Minimal set of Pathways" tool (MinPath v. 1.4, Ye and Doak (2009)) was used to obtain a conservative estimation of pathways.

5. The MAGs construction

The contigs of the sub-sample (n = 3) of each cow manure (n = 3) and composted cow manure samples were co-assembled separately using MEGAHIT v.1.2.9 (Li et al., 2016) with the same parameters (-min-contig-len 2000).
Altamira-Onset, 
Altamira-End, 
Ixtenco-Onset, 
Ixtenco-End, 
Ixtacuixtla-Onset,
Ixtacuixtla-End. 

The reads by sample were mapped to all the contigs of the co-assembly  using Bowtie2 with default settings. 

All assembled, mapped, and sorted scaffolds were binned using Concoct v.1.1, MetaBAT2 v.1.7 and MaxBin2 v.2.2.4 with default parameters.

Bins were further refined by combination and consensus to generate accurate bins with DasTool. 

The quality of genome bins was assessed using CheckM2 v.1.0.2 to estimate the completeness and contamination of MAGs. 
Only high-quality MAGs (completeness ≥ 80 % and contamination ≤ 10%) are given 

6. Taxonomy of MAGs

We use the GTDB-Tk v.0.3.0 database against the DasTool outputs was used for taxonomic annotations. Database (release 214) (Parks et al., 2018).

The relative abundance was estimated with CoverM v.0.7.0 using the percentage of reads mapping to each MAG. 

7. Functional prediction of the MAGs
   
Was formed with BlastP, using a handmade curated database related to nitrogen activity, 
methane emissions and carbon fixation. The AA sequences was downloaded from NCBI database and concatenated with cat in linux console.
