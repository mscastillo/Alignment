#!/bin/bash

## PARAMETERS ##########################################################

   FOLDER="/home/Programs/EMBOSS-6.6.0/emboss"
   PATH=$PATH:$FOLDER
   FILE="sequences.fastq"
   TAGS="tags.fasta"

########################################################################

while IFS=$'\n' read -r LINE ; do

	if [[ $( echo $LINE | grep ">" ) == "" ]] ; then
		echo ">"$NAME > $NAME.fasta
		echo $LINE >> $NAME.fasta
		# Command to perform tha optimum alignment
		needle  -datafile $FOLDER/data/EDNAFULL  -sformat1 fasta -snucleotide1 -asequence $NAME.fasta  -sformat2 fastq -snucleotide2 -bsequence $FILE  -outfile $NAME.needle  -awidth3 100 -gapopen 100 -gapextend 10  -endweight -endopen 1 -endextend 1  -nobrief
		COUNTS=$( cat $NAME.needle | grep "Identity:" | grep -o -P "(\d+)/(\d+)" | awk 'BEGIN{FS="/"}{ if ( 18<($1) ) print $0 }' | wc -l )
		echo $NAME$'\t'$COUNTS
	else
		NAME=$(echo $LINE | tr -d ">")
	fi
done < $TAGS
