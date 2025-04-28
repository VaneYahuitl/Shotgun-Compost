##!/bin/bash
# -*- coding: utf-8 -*-

# Author: Vanessa Yahuitl  <vaneyahuitl@gmail.com>
#Para Ubuntu

#CREACCIÓN DE MAGS A PARTIR DE MUESTRAS DE COMPOSTA

#Activa megahit (recuerda que está en un ambiente conda)
conda activate megahit

directorio="/run/media/dendooven/Local Disk/Composta/Ixtacuixtla_clean"

#Se requiere hacer un coensamble de las muestras que  provinenen del mismo sitio y del mismo tiempnter
#Haremos coensamble de las muestras por sitio 
#Otro ensamble de las muestras por tiempo

#Crea una liga simbólica a la carpeta que contiene las lecturas filtradas por calidad

ln -s /ruta/media/dendooven/Local Disk/Composta/IXTA-CLEAN

#Realiza el coensamble de lecturas que parearon y no parearon entre ellas

#IXTACUIXTLA END
nohup megahit -1 3-I-17-E-R1.fastq.gz, 3-I-15-Ef-R1.fastq.gz, IXTA-CLEAN/3-I-13-E-R1.fastq -2 IXTA-CLEAN/3-I-17-E-R2.fastq, IXTA-CLEAN/3-I-15-E-R2.fastq, IXTA-CLEAN/3-I-13-E-R2.fastq -o megahit_coassembly_IXTACUIXTLA_END -t 10 --min-contig-len 1500
#En mi lap corrí:
megahit -1 3-I-17-E-R1.fastq.gz,3-I-15-Ef-R1.fastq.gz,3-I-13-EF-R1.fastq.gz -2 3-I-17-E-R2.fastq.gz,3-I-15-Ef-R2.fastq.gz,3-I-13-EF-R2.fastq.gz -o /tmp/IXTA_END -t 10 --min-contig-len 2000

#IXTACUIXTLA ONSET
nohup megahit -1 IXTA-CLEAN/3-I-17-O-R1.fastq, IXTA-CLEAN/3-I-15-O-R1.fastq, IXTA-CLEAN/3-I-13-O-R1.fastq -2 IXTA-CLEAN/3-I-17-O-R2.fastq, IXTA-CLEAN/3-I-15-O-R2.fastq, IXTA-CLEAN/3-I-13-O-R2.fastq -o megahit_coassembly_IXTACUIXTLA_ONSET -t 40 --min-contig-len 1500
#En mi lap corrí:
megahit -1 3-I-17-O-R1.fastq.gz,3-I-15-Of-R1.fastq.gz,3-I-13-Of-R1.fastq.gz -2 3-I-17-O-R2.fastq.gz,3-I-15-Of-R2.fastq.gz,3-I-13-Of-R2.fastq.gz -o /tmp/IXTA_ONSET -t 10 --min-contig-len 2000

#cambiamos de directorio
ln -s /ruta/media/dendooven/Local Disk/Composta/ALT-CLEAN
#ALTAMIRA END 
# AJUSTAMOS A 2000 LA LONGITUD DE LOS CONTIGS A GENERAR 
megahit -1 2-A-10-E-R1.fastq.gz,2-A-7-E-R1.fastq.gz,2-A-8-E-R1.fastq.gz -2 2-A-10-E-R2.fastq.gz,2-A-7-E-R2.fastq.gz,2-A-8-E-R2.fastq.gz -o /tmp/ALT_END -t 60 --min-contig-len 2000

#ALTAMIRA ONSET
nohup megahit -1 ALT-CLEAN/2-A-7-O-R1.fastq, ALT-CLEAN/2-A-8-O-R1.fastq, ALT-CLEAN/2-A-10-O-R1.fastq -2 ALT-CLEAN/2-A-7-O-R2.fastq, ALT-CLEAN/2-A-8-O-R2.fastq, ALT-CLEAN/2-A-10-O-R2.fastq  -o megahit_coassembly_ALTAMIRA_ONSET -t 40 --min-contig-len 1500

#cambiamos de directorio
ln -s /ruta/media/dendooven/Local Disk/Composta/IXTE-CLEAN

#IXTENCO END
nohup megahit -1 IXTE-CLEAN/1-I-1-E-R1.fastq, IXTE-CLEAN/1-I-2-E-R1.fastq, IXTE-CLEAN/1-I-3-E-R1.fastq -2  IXTE-CLEAN/1-I-1-E-R2.fastq, IXTE-CLEAN/1-I-2-E-R2.fastq, IXTE-CLEAN/1-I-3-E-R2.fastq -o megahit_coassembly_IXTENCO_END -t 40 --min-contig-len 1500
#Corrí en mi computadora para longitud mínima de 2000
megahit -1 1-I-1-E_1.fastq.gz,1-I-2-E_1.fastq.gz,1-I-3-E_1.fastq.gz -2 1-I-1-E_2.fastq.gz,1-I-2-E_2.fastq.gz,1-I-3-E_2.fastq.gz -o /tmp/IXTE_END -t 10 --min-contig-len 2000
#IXTENCO ONSET
nohup megahit -1 IXTE-CLEAN/1-I-1-O-R1.fastq, IXTE-CLEAN/1-I-2-O-R1.fastq, IXTE-CLEAN/1-I-3-O-R1.fastq -2  IXTE-CLEAN/1-I-1-O-R2.fastq, IXTE-CLEAN/1-I-2-O-R2.fastq, IXTE-CLEAN/1-I-3-O-R2.fastq -o megahit_coassembly_IXTENCO_ONSET -t 40 --min-contig-len 1500

conda 

##### PARA CONSTRUIR EL INDEX ASOCIADO A CADA COENSAMBLE


bowtie2-build final.contigs.fa  assembly_index_ixta_onset


#Nota: se construye el index para cada coensamble realizado, se van a generar varios archivos de index, solo hay que poner el prefijo del nombre de index y bowtie va a usar todos los archivos de index generados para el siguiente paso

#mapeo del index del coensamble con la muestra 1-I-1-E
#Le damos 10 hilos al proceso 
bowtie2 -q -x assembly_index_ixte_end -1 ../clean_ixte_end/1-I-1-E_1.fastq.gz -2 ../clean_ixte_end/1-I-1-E_2.fastq.gz  --no-unal -p 10 -S sample_1-I-1-E.sam

#Mapeo de index del coensamble con la muestra 
bowtie2 -q -x assembly_index_ixte_end -1 ../clean_ixte_end/1-I-2-E_1.fastq.gz -2 ../clean_ixte_end/1-I-2-E_2.fastq.gz  --no-unal -p 10 -S sample_1-I-2-E.sam

bowtie2 -q -x assembly_index_ixte_end -1 ../clean_ixte_end/1-I-3-E_1.fastq.gz -2 ../clean_ixte_end/1-I-3-E_2.fastq.gz  --no-unal -p 10 -S sample_1-I-3-E.sam

#Convertimos los archivos .sam a .bam con samtools 

samtools view -b -o sample_1-I-1-E.bam sample_1-I-1-E.sam && \
samtools view -b -o sample_1-I-2-E.bam sample_1-I-2-E.sam && \
samtools view -b -o sample_1-I-3-E.bam sample_1-I-3-E.sam

#ordenar e indexar el bam
samtools sort -o sample_1-I-1-E-sort.bam sample_1-I-1-E.bam && \
samtools sort -o sample_1-I-2-E-sort.bam sample_1-I-2-E.bam && \
samtools sort -o sample_1-I-3-E-sort.bam sample_1-I-3-E.bam

#nota: primero va el nombre del archivo de salida y luego el de entrada

samtools index sample_1-I-1-E-sort.bam && \
samtools index sample_1-I-2-E-sort.bam && \
samtools index sample_1-I-3-E-sort.bam 

#Los indices son importantes para el procesamiento con Concoct 


#BINING
#El Bining se hace con Metabat, se instala la versión con soporte 
https://bitbucket.org/berkeleylab/metabat/src/master/
#En algunos casos es necesario modificar la configuración del Kernel, porque metabat requiere
#usar el sistema antiguo "vsyscall"
#Para comprobar si se tiene habilitado se debe buscar enlistado "vsyscall" con: 
cat /proc/self/maps
#En caso de que no esté:
#Para incluir la configuración en .wslconfig colocar lo sigiente:

kernelCommandLine = vsyscall=emulate

#calcular la cobertura para cada muestra usar los archivos .bam ordenados para cada muestra

jgi_summarize_bam_contig_depths --outputDepth htn-depth_1-I-1-E.txt sample_1-I-1-E-sort.bam && \
jgi_summarize_bam_contig_depths --outputDepth htn-depth_1-I-2-E.txt sample_1-I-2-E-sort.bam && \
jgi_summarize_bam_contig_depths --outputDepth htn-depth_1-I-3-E.txt sample_1-I-3-E-sort.bam


#crear una carpeta
#mkdir results/metabat_ixte_end

#obtener los bins
#nohup metabat -i megahit_coassembly_male/final.contigs.fa -a htn-depth_113_26M6-I.txt -o results/metabat_bins_machos/bins_113_26M6-I --saveCls --minCV 0.1 -m 2000
metabat2 -i final.contigs.fa -a htn-depth_1-I-1-E.txt  -o metabat_ixte_end/ixte_1-I-1-E --saveCls --minCV 0.1 -m 2000 -v
#[00:37:01] Finished Building TNF Graph (111985 vertices and 7250423 edges) [-58.4Gb / 61.8Gb]
#[00:37:21] Building SCR Graph and Binning (103243 vertices and 1257562 edges) [P = 95.00%; -58.3Gb / 61.8Gb]
#[00:37:39] 85.97% (595509162 bases) of large (>=2000) and 0.00% (0 bases) of small (<2000) contigs were binned.
#234 bins (595509162 bases in total) formed.

metabat2 -i final.contigs.fa -a htn-depth_1-I-2-E.txt  -o metabat_ixte_end/ixte_1-I-2-E --saveCls --minCV 0.1 -m 2000 -v && \
metabat2 -i final.contigs.fa -a htn-depth_1-I-3-E.txt  -o metabat_ixte_end/ixte_1-I-3-E --saveCls --minCV 0.1 -m 2000 -v
#Para 1-I-2-E
#222 bins (555801469 bases in total) formed.
#Para 1-I-3-E
#239 bins (587985814 bases in total) formed.
#HAREMOS LO MISMO CON MAXBIN

#conda activate maxbin_env
metabat2 -i final.contigs.fa -a htn-depth_1-I-2-E.txt  -o metabat_ixte_end/ixte_1-I-2-E --saveCls --minCV 0.1 -m 2000 -v && \
metabat2 -i final.contigs.fa -a htn-depth_1-I-3-E.txt  -o metabat_ixte_end/ixte_1-I-3-E --saveCls --minCV 0.1 -m 2000 -v
#crear la carepta results/maxbin_bins_ixte

metabat2 -i final.contigs.fa -a htn-depth_3-I-13-O.txt  -o metabat_ixte_end/ixte_3-I-13-O --saveCls --minCV 0.1 -m 2000 -v && \
metabat2 -i final.contigs.fa -a htn-depth_3-I-15-O.txt  -o metabat_ixte_end/ixte_3-I-15-O --saveCls --minCV 0.1 -m 2000 -v && \
metabat2 -i final.contigs.fa -a htn-depth_3-I-17-O.txt  -o metabat_ixte_end/ixte_3-I-17-O --saveCls --minCV 0.1 -m 2000
#HAREMOS LO MISMO CON MAXBIN
#conda activate maxbin_env
#crear la carepta results/maxbin_bins_ixte
#mkdir maxbin

#obtener los bins para cada muestra
run_MaxBin.pl -thread 10 -contig final.contigs.fa -out  metabat_ixte_end/ixte_1-I-1-E -abund htn-depth_1-I-1-E.txt && \
run_MaxBin.pl -thread 10 -contig final.contigs.fa -out  maxbin_ixte_end/maxbin_1-I-2-E/ixte_1-I-2-E -abund htn-depth_1-I-2-E.txt && \
runls_MaxBin.pl -thread 10 -contig final.contigs.fa -out  maxbin_ixte_end/ixte_1-I-3-E -abund htn-depth_1-I-3-E.txt
#nota1: usar el archivo htn-depth.txt que se generó con Metabat
#nota2: usar los final.contigs.fa del coensamble
#nota3: se hace para cada muestra, por lo tanto en una carpeta guardar los bins de maxbin de todas las muestras de cada coensamble, por ejemplo: maxbin_bins_machos
run_MaxBin.pl -thread 10 -contig final.contigs.fa -out  maxbin_ixte_on/ixte_1-I-1-O -abund htn-depth_1-I-1-O.txt && \ 
run_MaxBin.pl -thread 10 -contig final.contigs.fa -out  maxbin_ixte_on/ixte_1-I-2-O -abund htn-depth_1-I-2-O.txt && \ 
run_MaxBin.pl -thread 10 -contig final.contigs.fa -out  maxbin_ixte_on/ixte_1-I-3-O -abund htn-depth_1-I-3-O.txt -verbose

#HAREMOS LO MISMO CON CONCOT
#Activa Concoct (recuerda que esta en un ambiente conda)
conda activate concoct_env
#crea la carpeta results/concoct_machos
mkdir concoct_ixte_end

#fragmentar los contigs por coensamble  
cut_up_fasta.py final.contigs.fa -c 10000 -o 0 --merge_last -b concoct_ixte_end/SplitAssembly-htn.bed > concoct_ixte_end/htn.fasta-split10K.fa

#Calcular la cobertura de todas las muestras del coensamble
#concoct_coverage_table.py concoct_ixte_end/SplitAssembly-htn.bed sample_1-I-1-E-sort.bam sample_1-I-2-E-sort.bam sample_1-I-3-E-sort.bam > concoct_ixte_end/concoct_coverage_table_htn_ixte_end.tsv
#SE HACEN CON LOS ARCHIVOS ORDENADOS TIPO -sort.bam
concoct_coverage_table.py concoct_ixta_end/SplitAssembly-htn.bed 3-I-13-EF-sort.bam 3-I-15-Ef-sort.bam 3-I-17-E-sort.bam > concoct_ixta_end/concoct_coverage_table_htn_ixta_end.tsv

concoct_coverage_table.py concoct_ixte_end/SplitAssembly-htn.bed sample_1-I-1-E-sort.bam sample_1-I-2-E-sort.bam sample_1-I-3-E-sort.bam > concoct_ixte_end/concoct_coverage_table_htn_ixte_end.tsv

concoct_coverage_table.py concoct_ixte_end/SplitAssembly-htn.bed sample_1-I-1-E.bam sample_1-I-2-E.bam sample_1-I-3-E.bam > concoct_ixte_end/concoct_coverage_table_htn_ixte_end.tsv

#Nota: para generar el archivo htn.tsv que contiene los datos de cobertura de todas las muestras del coensamble, se escriben los nombres de todos los archivos bam de ese conensamble separados por un espacio

#Obtener los bins del coensamble

concoct -l 2000 -t 1 --coverage_file concoct_coverage_table_htn.tsv --composition_file htn.fasta-split10K.fa --basename concot --iterations 500 -b concoct_ixte_end

#Combinar los contigs


merge_cutup_clustering.py concoct_output_male/clustering_gt1500.csv > concoct_output_male/clustering_merged_1500.csv

merge_cutup_clustering.py concoct_ixte_end_clustering_gt2000.csv   > concoct_ixte_end_clustering_merged_gt2000.csv

#extraer los bins en archivos fasta individuales 

#mkdir concoct_output_male/fasta_bins

extract_fasta_bins.py final.contigs.fa concoct_ixte_end/concoct_ixte_end_clustering_merged_gt2000.csv --output_path concoct_ixte_end/fasta_bins

#nota1: se utilizan los final.contigs.fa del coensmable
#nota2: el numero en el nombre de este archivo  clustering_gt1500.csv, cambia por default dependiendo del tamaño del contig seleccionado con la opción -l, por default es de 1000
#SplitAssembly-htn.bed contiene una lista de los contigs creados, con la información de las regiones específicas de los fragmentos cortados de los contigs originales

#htn.fasta-split10K.fa contiene los contigs originales cortados a una longitud de exactamente 10k

#-t 40 40 threads

#-l tamaño del contig

#-c el valor de 10000 es para que corte los frgamentos en ese tamaño de bases

#Para más información consultar el manual de Concot


#Activa DAS Tool (recuerda que esta en un ambiente conda)
#conda activate dastool

#dastool machos de maxbin
Fasta_to_Contig2Bin.sh -i maxbin_ixte_end  -e fasta > maxbin_ixte_end_scaffolds2bin.tsv

#dastool machos de metabat
Fasta_to_Contig2Bin.sh -i metabat_ixte_end -e fa > metabat__ixte_end_scaffolds2bin.tsv

#dastool machos de concoct
Fasta_to_Contig2Bin.sh -i fasta_bins -e fa > concoct_ixte_end_scaffolds2bin.tsv

#dastool machos de concoct-metabat-maxbin
DAS_Tool -i maxbin_ixte_end_scaffolds2bin.tsv,metabat__ixte_end_scaffolds2bin.tsv,concoct_ixte_end_scaffolds2bin.tsv -l maxbin,metabat,concoct -c final.contigs.fa -o Dastool/htn_bins_DASTool_ixte_end -t 10 --search_engine diamond --write_bins


#Activa checkm
#Para el uso de CHECKM 1:
#conda activate checkm-genome
checkm lineage_wf -t 10 -x fa Dastool/htn_bins_DASTool_ixte_end_DASTool_bins DAS_Tool_bins_ixte_end -f CheckM-DAS_Tool_bins_ixte_end.tx
#PARA EL USO DE CHECKM2 
#Dentro del ambiente de DasTool

checkm2 predict --threads 10 --input Dastool/htn_bins_DASTool_ixte_on_DasTool_bins --output-directory checkm_ixte_on -x fa



#Activa GTDBTK
conda activate gtdbtk-2.1.1

gtdbtk classify_wf --genome_dir Dastool/htn_bins_DASTool_ixte_end_DASTool_bins --out_dir bin_tax_ann_ixte_end --cpus 10 -x fa

# ASIGNACIÓN FUNCIONAL CON PROKKA
# DESDE EL AMBIENTE DE PROKKA
#USANDO KOFAM SCAN


for i in Dastool/htn_bins_DASTool_alt_on_DASTool_bins*.fa ; do prodigal -i $i -o $i.txt -a $i.faa ; done

#SE GENERAN DOS ARCHIVOS uno de texto y uno .faa

for i in Dastool/htn_bins_DASTool_alt_on_DASTool_bins*.faa ; do 
  /exec_annotation -o $i.txt $i --report-unannotated --cpu 40 -p /profiles/ -k /ko_list; 
done

##DETECCIÓN DE GENES CON DRAM

##Asignacion taxonómica con la Ko LIST DE 	2024-12-26 16:58	854K	 "https://www.genome.jp/ftp/db/kofam/archives/2024-12-02/"
#SALÍA ERROR EN K27963
#CAMBIANDO A 	LA ko_List de 2025-01-22 02:40	857K	 

for i in Dastool/htn_bins_DASTool_ixte_end_DASTool_bins/*.faa ; do /home/vaneyahuitl/kofam_scan/exec_annotation -o $i.txt $i --report-unannotated  --cpu 10 -p /home/vaneyahuitl/profiles -k /home/vaneyahuitl/ko_list; done

for i in *.faa; do /home/vaneyahuitl/kofam_scan/exec_annotation -o $i.txt $i --report-unannotated --cpu 10 -p /media/Data/metagenomics/kofascam/kofam_scan-master/profiles/ -k /media/Data/metagenomics/kofascam/kofam_scan-master/ko_list; 
done

#INSTALL INTERPROSCAN
mkdir my_interproscan
cd my_interproscan
wget https://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/5.73-104.0/interproscan-5.73-104.0-64-bit.tar.gz
wget https://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/5.73-104.0/interproscan-5.73-104.0-64-bit.tar.gz.md5

# Recommended checksum to confirm the download was successful:
md5sum -c interproscan-5.73-104.0-64-bit.tar.gz.md5
# Must return *interproscan-5.73-104.0-64-bit.tar.gz: OK*

#RUTA DONDE PUSE INTERPROSCAN
#LO INSTALÉ DENTRO DEL AMBIENTE DE CONDA 

/home/vaneyahuitl/my_interproscan/interproscan-5.73-104.0
#Voy a la carpeta de los BINS 


for i in $(ls *.faa); do interproscan.sh -cpu 10 -goterms -pa -i $i > Log_Interpro_Scan_$i.txt; done
 

#Para estimar la abundancia relativa de los MAGS a partir de la covertura usamos CoverM 
#Estamos usando la versión coverm 0.7.0


#Calcular a partir de los bins en .fna (que en nuestro caso usaremos .faa) y los archivos sort.bam

 coverm genome --bam-files my.bam --genome-fasta-directory genomes_directory/

#Opción 2:
 #Calcular a partir de las lecturas limpias en pair end y los bins en .fna (que en nuestro caso usaremos .faa) 


#Para convertir los rchivos.fa de los bins en .fna
for file in *.fa; do mv "$file" "${file%.fa}.fna"; done

coverm genome \
  --coupled 3-I-13-Of-R1.fastq.gz  3-I-13-Of-R2.fastq.gz  \
  3-I-15-Of-R1.fastq.gz   3-I-15-Of-R2.fastq.gz \
  3-I-17-O-R1.fastq.gz  3-I-17-O-R2.fastq.gz \
  --genome-fasta-directory \
  Dastool/htn_bins_DASTool_ixta_onset_DASTool_bins \
  -m mean relative_abundance covered_fraction \
  -t 10 \
  -o output_coverm_ixta_onset.tsv

coverm genome \
  --coupled 3-I-13-EF-R1.fastq.gz  3-I-13-EF-R2.fastq.gz  \
  3-I-15-Ef-R1.fastq.gz   3-I-15-Ef-R2.fastq.gz \
  3-I-17-E-R1.fastq.gz  3-I-17-E-R2.fastq.gz \
  --genome-fasta-directory \
  Dastool/htn_bins_DASTool_ixta_end_DASTool_bins \
  -m mean relative_abundance covered_fraction \
  -t 10 \
  -o output_coverm_ixta_end.tsv


coverm genome \
  --coupled 2-A-7-E-R1.fastq.gz  2-A-7-E-R2.fastq.gz  \
   2-A-8-E-R1.fastq.gz   2-A-8-E-R2.fastq.gz \
  2-A-10-E-R1.fastq.gz   2-A-10-E-R2.fastq.gz  \
  --genome-fasta-directory \
  Dastool/htn_bins_DASTool_alt_end_DASTool_bins \
  -m mean relative_abundance covered_fraction \
  -t 10 \
  -o output_coverm_alt_end.tsv

coverm genome \
  --coupled 1-I-1-O_1.fastq.gz     1-I-1-O_2.fastq.gz    \
   1-I-2-O_1.fastq.gz    1-I-2-O_2b.fastq.gz   \
 1-I-3-O_1.fastq.gz   1-I-3-O_2.fastq.gz  \
  --genome-fasta-directory \
  Dastool/htn_bins_DASTool_ixta_onset_DASTool_bins \
  -m mean relative_abundance covered_fraction \
  -t 10 \
  -o output_coverm_ixta_onset.tsv

coverm genome \
  --coupled 1-I-1-E_1.fastq.gz      1-I-1-E_2.fastq.gz     \
   1-I-2-E_1.fastq.gz    1-I-2-E_2.fastq.gz   \
 1-I-3-E_1.fastq.gz   1-I-3-E_2.fastq.gz  \
  --genome-fasta-directory \
  Dastool/htn_bins_DASTool_ixta_onset_DASTool_bins/Ixte_end_60_10_bins \
  -m mean relative_abundance covered_fraction \
  -t 10 \
  -o output_coverm_ixta_onset_60-10.tsv




  #Para encontrar genes específicos para una actividad metabólica determinada
  #sE DESCARGAN LAS secuencias de aminoácidos para cada gen implicado en diferentes rutas metabólicas 
  #Se concatenan los genes descargados  

  cat NIT/*.fasta > N-DB.fasta

  #BLAST-P necesita genrar archivos específicos para poder usar esa base de datos
  #Así que corremos el siguiente comando:

makeblastdb -in N-DB.fasta -dbtype prot -out N-DB

   #Se van a generar diferentes archivos de tipo  N-DB.psq, N-DB.pin, N-DB.phr

#Se utilizan solo los Bins que han pasado por el control de calidad seleccionado 60-10
#Se almacenan en una carpeta y como anteriormente para usarse con CoverM fueron transformados a .fna
#Se transforman en .fa de nuevo

for file in *.fna; do mv "$file" "${file%.fna}.fa"; done

#Una vez que se tienen los bins en .fa se les aplica prodigal para obtener secuencias de aminoácidos 
for i in Dastool/filt_bins_alt_on/*.fa ; do prodigal -i $i -o $i.txt -a $i.faa ; done

#Ahora que tenemos aechivos de tipo .faa con aminoácidos para cada bin podemos aplicar BlastP 
#Compararemos los .faa de la carpeta de bins contra la base de datos concatenada
#Es preferible que la DB y sus archivos adicionales estén en la misma carpeta donde se llama
#los .faa no es necesario que estén en la misma ruta, 


 for file in Dastool/filt_bins_alt_on/*.faa; do
    blastp -query "$file" -db N-DB -out "${file%.faa}_blastp_results_ALT_ON.txt" -evalue
1e-5 -outfmt 6 -num_threads 10
done


for file in Bins_all/*.faa; do
blastp \
-query "$file" \
-db /mnt/c/Users/rodri/Documents/Doctorado/7CUATRI/MAGS/base/N-DB\
-out "${file%.faa}_blastp_results_ALT_END.txt" \
-evalue 1e-5 \
-outfmt 6 \
-max_target_seqs 1 \
-num_threads 10 
done

