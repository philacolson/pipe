#!/usr/bin/perl

###################################################
#
# Test reader for vcf file
#
###################################################

use strict;
use warnings;
use CLASS::SNP;

# pass a variable with the filename to the reader

# package TEST;
my $file = "CEU.exon.2010_06.genotypes.vcf";
our @SNPS = `/usr/bin/perl vcf_reader.pl $file`;
foreach (@SNPS)
{
	print $_;
}
# require "/Users/coryprzybyla/Desktop/BuffaloRA/TEST_SCRIPTS/vcf/vcf_reader.pl";

