Alignment
=========


# `tags_counter.sh`

This script takes a *fasta* file with short tags and look for them on the sequences of a given *fastq* file. It depends on `needle` from the [EMBOSS tools](http://www.ebi.ac.uk/Tools/emboss/).

```bash
head -5 sequences.fasta 
>EMBOSS_001
ATACAAAGATAGATA
>EMBOSS_002
GATAATACAAAGATA
>EMBOSS_003
```

The resulting alignment profiles will be saved in individual files for each tag in the *fasta* file. In addition, it will count the number of occurrences with up to a given number of mismatches.


# `tags_mismatches.sh`

This script takes the output files from `tags_counter.sh` and retrieves the alignment reports of sequences with a given number of mismatches.

```bash
head -5 EMBOSS_001.needle.MATCHES_18 
# 1: SN0123:456:7:8910:1112:1314#ATACA
EMBOSS_001         1--------------------------ATACAAAGATAGATA----------     15
                                              ||.||||.|||||||
SN0123:456:7:      1 AATTCCAGCTGAGCGGGCCGGCCCTCAAGACAGACAATGATAGATAACTG     50
```
