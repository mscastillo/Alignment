#!/bin/bash

## PARAMETERS ##########################################################

   MATCHES="19"
   SUFFIX=$RANDOM

########################################################################


FILES=($( ls *.needle ))
for k in $( seq 0 $((${#FILES[@]} - 1)) ) ; do

	FILE=${FILES[$k]}
	OUTPUT=$FILE."MATCHES_"$MATCHES.sequences
	date ; echo $FILE
	grep -n -P "$MATCHES/(\d+)" $FILE | grep "Identity"  | cut -f1 -d: > lines.$SUFFIX.txt
	
	while read LINE ; do
		awk -v NUMBER=$LINE 'NR == NUMBER-6 {print ; exit}' $FILE >> $OUTPUT
		awk -v NUMBER=$LINE 'NR == NUMBER+11 {print ; exit}' $FILE >> $OUTPUT
		awk -v NUMBER=$LINE 'NR == NUMBER+12 {print ; exit}' $FILE >> $OUTPUT
		awk -v NUMBER=$LINE 'NR == NUMBER+13 {print ; exit}' $FILE >> $OUTPUT
		echo >> $OUTPUT
	done < lines.$SUFFIX.txt
	
	rm -f lines.$SUFFIX.txt
	
done
