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
my $file = "mafFileSample.maf";
our @SNPS = `/usr/bin/perl maf_reader.pl $file`;

# require "/Users/coryprzybyla/Desktop/BuffaloRA/TEST_SCRIPTS/vcf/vcf_reader.pl";

print "@SNPS";