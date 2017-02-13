# vcf2tree
Create phylogenetic tree using whole genome sequencing data

Requirement:

Linux/Unix/MacOS environment;

VCF files generated for different individuals against the same reference sequence;

A text file of the vcf file names seperated in different lines.

e.g. a vcf.txt file has the following content
     sample1
     sample2
     sample3
     ......

corresponds to sample1.vcf, sample2.vcf, sample3.vcf...... in the same directory.

How to run:

sh vcf2tree.sh vcf.txt

What will be generated:

Several files will be generated. The most useful one is the fasta file containing concatednated informative sites for all individuals. The following tree construction is using Raxml. It can be used in any tree bulding packages.
