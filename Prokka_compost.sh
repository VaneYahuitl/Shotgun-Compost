#PROKKA
# Author: Vanessa yAHUITL  <vaneyahuitl@gmail.com>
#Para Ubuntu 20.04


#Ixtacuixtla
directorio= "run/media/dendooven/Local \ Disk/Composta/Ixta_assembly"

# Choose the names of the output files
#% prokka --outdir annotation_compost --prefix contigs_comp --cpus 8 --mincontiglen 200 --prodigaltf
#% less -S mutant/K12_mut.tsv 

prokka Ixta_3I13O.fa --outdir prokka_out_3I13O --norrna --notrna --metagenome --cpus 8
prokka Ixta_3I13E.fa --outdir prokka_out_3I13E --norrna --notrna --metagenome --cpus 8
prokka Ixta_3I15E.fa --outdir prokka_out_3I15E --norrna --notrna --metagenome --cpus 8
prokka Ixta_3I15O.fa --outdir prokka_out_3I15O --norrna --notrna --metagenome --cpus 8
prokka Ixta_3I17E.fa --outdir prokka_out_3I17E --norrna --notrna --metagenome --cpus 8
prokka Ixta_3I17O.fa --outdir prokka_out_3I17O --norrna --notrna --metagenome --cpus 8

#Obtenemos diferentes outputs
#busca en un archivo  GFF las líneas que contienen información sobre números de clasificación de enzimas
#(eC_number) y reformatea en un archivo con dos columnas: una para el ID y otra para el número de clasificación de enzimas.

egrep "eC_number=" PROKKA_11302023.gff |cut -f9 | cut -f1,2 -d ';'| sed 's/ID=//g'| sed 's/;eC_number=/\t/g' > ec_3I15E.ec
egrep "eC_number=" 2-A-10-E_prokka.gff |cut -f9 | cut -f1,2 -d ';'| sed 's/ID=//g'| sed 's/;eC_number=/\t/g' > ec_2-A-10-E.cog


#busca líneas  que contengan  "COG", y extrae información específica
#luego guarda los resultados en un archivo con dos columnas: ID y número COG.
egrep "COG[0-9]{4}" $i |sed 's/ID=\(\w\+\).*\(COG[0-9]\+\).*/\1\t\2/g'| cut -f9,10 > cog_3I15E

######################   ANÁLISIS CON MINPATH ########################

#Descargo el workshop 
#git clone https://github.com/EnvGen/metagenomics-workshop.git

### SEGÚN EL WORKFLOW DE  https://metagenomics-workshop.readthedocs.io/en/latest/annotation/functional_annotation.html

python /mnt/c/MinPath/MinPath.py -any PROKKA.2-A-10-E.ec -map /mnt/c/metagenomics-workshop/reference_db/metacyc/ec.to.pwy -report report_PROKKA.2-A-10-E.ec.metacyc.minpath > MinPath.Metacyc.2-A-10-E.log

python /mnt/c/MinPath/MinPath.py -any PROKKA.2-A-10-E.ec -map /mnt/c/metagenomics-workshop/reference_db/kegg/ec.to.pwy -report PROKKA.2-A-10-E.kegg.minpath > MinPath.KEGG.2-A-10-E.log
#######################################

#Para cuantificar los genomas uso los ensambles extraidos de MegaHit #final contigs
 bowtie2-build Alt_2A10E.fa Alt_2A10E.fa
#Se generan varios archivos tipo BT2 que serán usados para el siguiente paso
#Luego tomo los clean reads y les hago un mapeo con bowtie para extraer un archivo .sam
 bowtie2 -p 8 -x Alt_2A10E.fa -1 2-A-10-E-R1.fastq.gz -2 2-A-10-E-R2.fastq.gz -S 2-A-10-E.map.sam --threads 12

#Activo el entorno de qiime2 para usar SamTools 
conda activate qiime2-shotgun-2023.9

#Vamos a convertir el archivo .sam a .bam
#Los archivos BAM son más ligeros 
#samtools sort -o 121.map.sorted.bam -O bam 121.map.sam
samtools sort -o 2-A-10-E.map.sorted.bam -O bam 2-A-10-E.map.sam
samtools sort -o 2-A-10-O.map.sorted.bam -O bam 2-A-10-O.map.sam
#El siguiente paso es cuantificar los genes, para ello hacemos un índice y nos gener un archivo .bai
samtools index 2-A-10-E.map.sorted.bam
#Usamos htsec para cuantificar los genes
#Necesito extraer un archivo .gff

bash /mnt/c/metagenomics-workshop/in-house/prokkagff2gtf.sh ~2-A-10-E_prokka.gff > 2-A-10-E_prokka.map.gtf

#en caso de no estar instalado "pip install HTSeq"
#Debo tener en el msimo directorio el mapeo tipo BAM, de lo contrario indicar la dirección,junto con el archivo .gtf generado

htseq-count  -t CDS -f bam  2-A-10-E.map.sorted.bam 2-A-10-E_prokka.map.gtf > 2-A-10-E_counting

#Luego usamos htseq para contar el número de lecturas asignadas a cada gen.
#Tenemos que decirle a htseq que el archivo está ordenado por coordenadas de alineación -r pos :

cut -f4,5,9 2-A-10-E_prokka.map.gtf | sed 's/gene_id //g' | gawk '{print $3,$2-$1+1}' | tr ' ' '\t' > 2-A-10-E.genelength

#Donde se enlistan los genes y las lecturas asignadas a cada gen 
#Tenemos que normalizar los resultados a transcripciones por millón
#TPM 
bash /mnt/c/metagenomics-workshop/in-house/tpm_table.py -n 2-A-10-E -c 2-A-10-E_counting -i <(echo -e "2-A-10-E\t100") -l 2-A-10-E.genelength > 2-A-10-E.tpm

#Como paso final para visualizar podemos hacer un Krona plot

#STEPH:
#python /mnt/c/metagenomics-workshop/in-house/genes.to.kronaTable2.py -i 2-A-10-E_prokka.gff -m /mnt/c/metagenomics-workshop/reference_db/cog/cat.hierarchy -n 2-A-10-E -c 2-A-10-E.tpm -o 2-A-10-E.krona.cog.table
#python /mnt/c/metagenomics-workshop/in-house/genes.to.kronaTable2.py -i 2-A-10-E_prokka.gff -m /mnt/c/metagenomics-workshop/reference_db/cog/cat.hierarchy -n 2-A-10-E -c 2-A-10-E.tpm -o 2-A-10-E.krona.cog.table
#python /mnt/c/metagenomics-workshop/in-house/genes.to.kronaTable2.py -i 2-A-10-E_prokka.gff -m /mnt/c/metagenomics-workshop/reference_db/kegg/pwy.hierarchy -n 2-A-10-E -c 2-A-10-E.tpm -o 2-A-10-E.krona.keg.table

#La terminal arroja la información de uso  para el script "genes.to.kronaTable2.py"

##workshop blog
python /mnt/c/metagenomics-workshop/in-house/genes.to.kronaTable2.py -i PROKKA.2-A-10-E.ec -m /mnt/c/metagenomics-workshop/reference_db/metacyc/ec.to.pwy -H /mnt/c/metagenomics-workshop/reference_db/metacyc/pwy.hierarchy -n 2-A-10-E -l <(grep "minpath 1" PROKKA.2-A-10-E.metacyc.minpath) -c 2-A-10-E.tpm -o 2-A-10-E.krona.metacyc.minpath.tab
python /mnt/c/metagenomics-workshop/in-house/genes.to.kronaTable2.py -i PROKKA.2-A-10-E.ec -m /mnt/c/metagenomics-workshop/reference_db/kegg/ec.to.pwy -H /mnt/c/metagenomics-workshop/reference_db/kegg/pwy.hierarchy -n 2-A-10-E -l <(grep "minpath 1" PROKKA.2-A-10-E.kegg.minpath) -c 2-A-10-E.tpm -o 2-A-10-E.krona.kegg.minpath.tab
python /mnt/c/metagenomics-workshop/in-house/genes.to.kronaTable2.py -i PROKKA.2-A-10-E.cog -m /mnt/c/metagenomics-workshop/reference_db/cog/cog.to.cat -H /mnt/c/metagenomics-workshop/reference_db/cog/cat.hierarchy -n 2-A-10-E -c 2-A-10-E.tpm -o 2-A-10-E.krona.COG.tab
#Para las tablas de Cog APARECE IndexError: list index out of range

ktImportText -o 2-A-10-E.krona.metacyc.minpath.html 2-A-10-E.krona.metacyc.minpath.tab
ktImportText -o 2-A-10-E.krona.kegg.minpath.html 2-A-10-E.krona.kegg.minpath.tab
ktImportText -o 2-A-10-E.krona.COG.html 2-A-10-E.krona.COG.tab

ktImportText kraken.report1,name1 kraken.report2,name2 kraken.report3,name3 -o tmp.htm

# Para hacer un merge de Krona chart usando Kronatools

ktImportKrona   -o krona_merge.htm \ krona_chart_1.html \ krona_chart_2.html \ krona_chart_3.html

#EJEMPLO:
ktImportKrona    -o IXTE.ONSET.krona_kegg_minpath.htm \ 1-I-1-O.krona.kegg.minpath.html \ 1-I-2-O.krona.kegg.minpath.html \ 1-I-3-O.krona.kegg.minpath.html

### CALCULAR LA COBERTURA
bash /mnt/c/metagenomics-workshop/in-house/prokkagff2bed.sh ~2-A-10-E_prokka.gff > 2-A-10-E.map.bed
bedtools coverage -hist -abam 2-A-10-E.map.markdup.bam -b 2-A-10-E.map.bed > 2-A-10-E.map.hist
bedtools coverage -hist -a 2-A-10-E.map.bed -b 2-A-10-E.map.markdup.bam > 2-A-10-E.map.hist
get_coverage_for_genes.py -i <(echo 2-A-10-E.map.hist) > 2-A-10-E.coverage
###################

