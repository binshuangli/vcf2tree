#!/bin/bash

#read in the list of vcf files as argument. Parse through the vcf file to extract position and reference sequence.
while read -r -u 2 f1 
do
	grep -v "#" $f1.vcf | cut -f 1,2,4,5 | awk '(length($3)==1)&&(length($4)==1)' > $f1.vcf2
	sed 's/\t/_/g' $f1.vcf2 > $f1.pos
done 2<$1

#generate the combined positions across all vcf files
cat *.pos | sort | uniq > uniq.pos

while read -r -u 2 f1
do
  #generate the difference between individual vcf file and the combined one
	grep -Fxvf $f1.pos uniq.pos | sed 's/_/\t/g' |awk '{ print $1"\t"$2"\t"$3"\t"$3 }'> $f1.diff.vcf
  
  #generate fasta file containing informtive sites only
  cat $f1.vcf2 $f1.diff.vcf | sort -k1,1 -k2,2n | cut -f 4 | perl -pe'chomp, s/$// unless eof' > $f1.informative.fa
	sed -i '1i>'$f1'' $f1.informative.fa
done 2<$1

#combine all fasta file for tree building
cat *informative.fa > all.informative.fa
