<h1 align="center"> Shotgun-Compost </h1>
Shotgun sequencing data analysis from cow manure compost samples:

## :hammer:Project stages
- `Stage 1`: Preprocessing data
- `Stage 2`: Taxonomy Read-Based
- `Stage 3`: Protein annotation
- `Stage 4`: Metabolic pathways

1.`Preprocessing data`:
Raw reads were mapped against the masked human reference genome GRCh38.p14 and the cow reference genome ARS-UCD1.3 using BBMap (https://sourceforge.net/projects/bbmap/). 

Unmapped reads to the human genome were trimmed using Trimommatic with an average Q-score < 20 and shorter than 50 nucleotides were discarded.

2.`Taxonomy Read-Based`:
High quality reads were used as inputs for the MEGAHIT assembler (Li et al., 2015). 
(--k-min 27 –k-max 127 and --k-step 10).
The minimum contig length was set to 500 nt.

3.`Protein annotation`:
Done with Prokka v. 1.13 using the metagenome setting for highly fragmented datasets (https://github.com/tseemann/prokka) (Seeman, 2014).
To quantify the genes, we used bowtie2 v. 2.5.3 (Langmead and Salzber, 2012) and quantified with HTSeq v. 2.0.3 (Anders et al., 2015). 

4. `Metabolic pathways`:

The generic feature annotation file (GFF Prokka's annotation output) was filtered to retain all genes with a KO identifier assigned.
The "Minimal set of Pathways" tool (MinPath v. 1.4, Ye and Doak (2009)) was used to obtain a conservative estimation of pathways.


## Citation

The results can be viewed and cited at https://doi.org/10.3389/fmicb.2024.1425548


