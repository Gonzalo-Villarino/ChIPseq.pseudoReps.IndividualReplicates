#!/bin/bash

fileName='Bowtie_SVP_FLC_FRI_rep1.bam.tagAlign.gz' # input tagAlign file name
outputDir='/home3/rnaseq-shared/Miguel/01_Bowtie/tagAlignFiles' # output directory for pseudoreplicate files
outputStub='Bowtie_SVP_FLC_FRI_rep1' # prefix name for pseudoReplicate files

nlines=$( zcat ${fileName} | wc -l ) # Number of reads in the tagAlign file
nlines=$(( (nlines + 1) / 2 )) # half that number
zcat "${fileName}" | shuf | split -d -l ${nlines} - "${outputDir}/${outputStub}" # This will shuffle the lines in the file and split it into two parts
gzip "${outputDir}/${outputStub}00"
gzip "${outputDir}/${outputStub}01"
mv "${outputDir}/${outputStub}00.gz" "${outputDir}/${outputStub}.pr1.tagAlign.gz"
mv "${outputDir}/${outputStub}01.gz" "${outputDir}/${outputStub}.pr2.tagAlign.gz"
