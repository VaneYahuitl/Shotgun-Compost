#!/bin/bash
# -*- coding: utf-8 -*-

# Author: Vanessa Yahuitl  <vaneyahuitl@gmail.com>
#Para Ubuntu


directorio="/mnt/c/Users/rodri/Documents/compost/Alt_clean"

mkdir mapeo_BWA_ALT


#Para cuantificar los genomas uso los ensambles extraidos de MegaHit #final contigs
#bowtie2-build Alt_2A10E.fa Alt_2A10E.fa

#Se generan varios archivos tipo BT2
#Luego tomo los clean reads y les hago un mapeo con bowtie para extraer un archivo .sam
 bowtie2 -x /mnt/c/Users/rodri/Documents/compost/assembly/Alt_assembly/Alt_2A10E.fa -1 2-A-10-E-R1.fastq.gz -2 2-A-10-E-R2.fastq.gz -S 2-A-10-E.map.sam --threads 10
 bowtie2 -x /mnt/c/Users/rodri/Documents/compost/assembly/Alt_assembly/Alt_2A10O.fa -1 2-A-10-O-R1.fastq.gz -2 2-A-10-O-R2.fastq.gz -S 2-A-10-O.map.sam --threads 10
 bowtie2 -x /mnt/c/Users/rodri/Documents/compost/assembly/Alt_assembly/Alt_2A7E.fa -1 2-A-7-E-R1.fastq.gz -2 2-A-7-E-R2.fastq.gz -S 2-A-7-E.map.sam --threads 10
 bowtie2 -x /mnt/c/Users/rodri/Documents/compost/assembly/Alt_assembly/Alt_2A7OF.fa -1 2-A-7-O-R1.fastq.gz -2 2-A-7-O-R2.fastq.gz -S 2-A-7-O.map.sam --threads 10
 bowtie2 -x /mnt/c/Users/rodri/Documents/compost/assembly/Alt_assembly/Alt_2A8E.fa -1 2-A-8-E-R1.fastq.gz -2 2-A-8-E-R2.fastq.gz -S 2-A-8-E.map.sam --threads 10
 bowtie2 -x /mnt/c/Users/rodri/Documents/compost/assembly/Alt_assembly/Alt_2A8O.fa -1 2-A-8-O-R1.fastq.gz -2 2-A-8-O-R2.fastq.gz -S 2-A-8-O.map.sam --threads 10
