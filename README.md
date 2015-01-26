Alignment
=========


# `tags_counter.sh`[:arrow_lower_right:](https://github.com/mscastillo/Alignment/blob/master/tags_counter.sh)

This script takes a *fasta* file with short tags and find them among the sequences of a given *fastq* file. It depends on `needle` from the [EMBOSS tools](http://www.ebi.ac.uk/Tools/emboss/) to perform the search.

```bash
head -5 sequences.fasta 
>EMBOSS_001
ATACAAAGATAGATA
>EMBOSS_002
GATAATACAAAGATA
>EMBOSS_003
```

`needle` is set up to perform the alignment, across the forward and reverse (and complement) sequences, with no gaps but mismatches. The resulting alignment profiles are saved in two individual files for each tag: one for the forward and tother for the reverse alignment. In addition, it will output for each tag the total number of alignments (both forward and reverse) with up to a given number of mismatches.


# `tags_mismatches.sh`[:arrow_lower_right:](https://github.com/mscastillo/Alignment/blob/master/tags_mismatches.sh)

This script takes the output files from `tags_counter.sh` and retrieves the alignment reports of sequences with a given number of mismatches.

```bash
head -5 EMBOSS_001.needle.MATCHES_13 
# 1: SN0123:456:7:8910:1112:1314#ATACA
EMBOSS_001         1--------------------------ATACAAAGATAGATA----------     15
                                              ||.||||.|||||||
SN0123:456:7:      1 AATTCCAGCTGAGCGGGCCGGCCCTATTCAAACATAGATATAGATAACTG     50
```
