#!/bin/bash

## PARAMETERS ##########################################################

   MATCHES="19"
   SUFFIX=$RANDOM

########################################################################

FILES=($( ls *.needle ))
for k in $( seq 0 $((${#FILES[@]} - 1)) ) ; do

	FILE=${FILES[$k]}
	OUTPUT=$FILE."MATCHES_"$MATCHES
	date
	echo $FILE
	grep -n -P "$MATCHES/(\d+)" $FILE | grep "Identity"  | cut -f1 -d: > lines.$SUFFIX.txt
	LINES=$( cat lines.$SUFFIX.txt | awk 'BEGIN{FS="\n";OFS="";ORS=""}{print $1-6,"p;",$1+11,",",$1+13,"p;"}' )
	sed -n $LINES $FILE > $OUTPUT	
	rm -f lines.$SUFFIX.txt
	
done

