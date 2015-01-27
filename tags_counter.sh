#!/bin/bash

## PARAMETERS ##########################################################
 # Input fastq file with the sequences
   FILE="sequences.fastq"
 # Input fasta file with the tags to find in $FILE
   TAGS="tags.fasta"
 # Maximum number of mismatches to allow when counting (set to zero for perfect alignment)
   MISMATCHES=1
########################################################################

# Adding to the $PATH the folder where the emboss suite is installed
  FOLDER="/home/Programs/emboss_6.5.7/EMBOSS-6.6.0/emboss" ; PATH=$PATH:$FOLDER

while IFS=$'\n' read -r LINE ; do

	if [[ $( echo $LINE | grep ">" ) == "" ]] ; then
		echo ">"$NAME > $NAME.fasta
		echo $LINE >> $NAME.fasta
		LENGHT=$( echo $LINE | wc -L )
		MATCHES=$(( $LENGHT - $MISMATCHES ))
		# Command to perform optimal alignment
		needle  -auto  -datafile $FOLDER/data/EDNAFULL  -sformat1 fasta -snucleotide1            -asequence $NAME.fasta  -sformat2 fastq -snucleotide2 -bsequence $FILE  -outfile $NAME.needle          -awidth3 100 -gapopen 100 -gapextend 10  -endweight -endopen 1 -endextend 1  -nobrief
		# Command to perform optimal alignment with the reverse-complement tag
		needle  -auto  -datafile $FOLDER/data/EDNAFULL  -sformat1 fasta -snucleotide1 -sreverse1 -asequence $NAME.fasta  -sformat2 fastq -snucleotide2 -bsequence $FILE  -outfile $NAME.reverse.needle  -awidth3 100 -gapopen 100 -gapextend 10  -endweight -endopen 1 -endextend 1  -nobrief
		# Counting the number of alignments with up to $MISMATCHES
		COUNTS=$( cat $NAME*.needle| grep "Identity:" | grep -o -P "(\d+)/(\d+)" | awk -v k=$MATCHES 'BEGIN{FS="/"}{ if ( k<=($1) ) print $0 }' | wc -l )
		echo $NAME$'\t'$COUNTS
		rm $NAME.fasta
	else
		NAME=$(echo $LINE | tr -d ">")
	fi

done < $TAGS
