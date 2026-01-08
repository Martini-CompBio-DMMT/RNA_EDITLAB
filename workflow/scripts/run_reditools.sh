#!/bin/bash

bam=$1 
sample=$(basename "${bam}")
sample=${sample%.bam}

genome=$2 # genome in fasta format
knownSites=$3 # Kknow sit can be GZ
threads=$4

. /mnt/resources/miniconda3/activate_conda 
conda activate reditools

REDItoolKnown=/mnt/projects/editing-pipelines/reditools/software-REDItools/REDItools/main/REDItoolKnown.py
echo "set Min. mapping quality score to 25 (STAR)"

python $REDItoolKnown -i $bam -f $genome -l $knownSites -o $sample -t $threads # (-m 60) 

