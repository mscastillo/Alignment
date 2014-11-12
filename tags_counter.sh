#!/bin/bash

## PARAMETERS ##########################################################

   FILE="sequences.fastq"
   TAGS="tags.fasta"
   FOLDER="/home/Programs/EMBOSS-6.6.0/emboss"
   PATH=$PATH:$FOLDER

########################################################################

while IFS=$'\n' read -r LINE ; do

	if [[ $( echo $LINE | grep ">" ) == "" ]] ; then
		echo ">"$NAME > $NAME.fasta
		echo $LINE >> $NAME.fasta
		# Command to perform optimal alignment
		needle  -auto  -datafile $FOLDER/data/EDNAFULL  -sformat1 fasta -snucleotide1            -asequence $NAME.fasta  -sformat2 fastq -snucleotide2 -bsequence $FILE  -outfile $NAME.needle          -awidth3 100 -gapopen 100 -gapextend 10  -endweight -endopen 1 -endextend 1  -nobrief
		# Command to perform optimal alignment with the reverse-complement tag
		needle  -auto  -datafile $FOLDER/data/EDNAFULL  -sformat1 fasta -snucleotide1 -sreverse1 -asequence $NAME.fasta  -sformat2 fastq -snucleotide2 -bsequence $FILE  -outfile $NAME.reverse.needle  -awidth3 100 -gapopen 100 -gapextend 10  -endweight -endopen 1 -endextend 1  -nobrief
		COUNTS=$( cat $NAME*.needle| grep "Identity:" | grep -o -P "(\d+)/(\d+)" | awk 'BEGIN{FS="/"}{ if ( 19<($1) ) print $0 }' | wc -l )
		echo $NAME$'\t'$COUNTS
	else
		NAME=$(echo $LINE | tr -d ">")
	fi
done < $TAGS
