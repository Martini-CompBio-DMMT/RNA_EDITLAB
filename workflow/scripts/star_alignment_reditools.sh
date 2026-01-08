#!/bin/bash

set -eux -o pipefail

export genomeIndexDir=$1
export fastq1=$2
export fastq2=$3
export sample=$4


STAR --runThreadN 8 \
--genomeDir $genomeIndexDir \
--genomeLoad NoSharedMemory \
--outFileNamePrefix ${sample}_ \
--outReadsUnmapped Fastx \
--outSAMtype BAM SortedByCoordinate \
--outSAMstrandField intronMotif \
--outSAMattributes All \
--readFilesCommand zcat \
--outFilterType BySJout \
--outFilterMultimapNmax 1 \
--alignSJoverhangMin 8 --alignSJDBoverhangMin 1 --outFilterMismatchNmax 999 \
--outFilterMismatchNoverLmax 0.04 --alignIntronMin 20 --alignIntronMax 1000000 \
--alignMatesGapMax 1000000 \
--readFilesIn $fastq1 $fastq2
