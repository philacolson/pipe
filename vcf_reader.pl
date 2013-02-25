#!/usr/bin/perl

###################################################
#
# Test reader for vcf file
#
###################################################

use strict;
use warnings;
use CLASS::SNP;

# open FH, '<', "CEU.exon.2010_06.genotypes.vcf";
open FH, '<', "$ARGV[0]";
# open FH, '<', $TEST::file;

# create a flag to kickoff parsing each line once the line with the headers
# is found.  Also need array of SNAPES.
my $foundheaders = 0;
my $snp_line = 0;
my @SNPS = ();

while (my $line = <FH>) {
	# once you've found the headers, this will begin to kickoff
	if ($foundheaders == 1)
	{
		# get line elements and create a new SNAPE object using the elements
		# matched to the header index
		my @lineArray = split("\t", $line);
		my $SNP = new CLASS::SNP();

		# set all the values.  Note that this could be done in a constructor
		### Need to check to verify that that position exists before setting value
		$SNP->CHROME(@lineArray[$HEADERS::CHROM]);
		$SNP->POS(@lineArray[$HEADERS::POS]);
		$SNP->ID(@lineArray[$HEADERS::ID]);
		$SNP->REF(@lineArray[$HEADERS::REF]);
		$SNP->ALT(@lineArray[$HEADERS::ALT]);
		$SNP->QUAL(@lineArray[$HEADERS::QUAL]);
		$SNP->FILTER(@lineArray[$HEADERS::FILTER]);

		# Add new SNAPE to the array
		$SNPS[$snp_line] = $SNP;
		$snp_line ++;
	};

	# Search for line with "#C" at the beginning.  This will contain the headers
	if ($line =~ m/#C/ ) {
		# strip the first # symbol from the headers
		my $subline = substr $line, 1;
		chomp($subline);

		# split the line into an array and index headers
		my @headers = split("\t", $subline);
		&assign_headers(\@headers);

		# check off foundheaders flag
		$foundheaders = 1;
	};
};
close FH;

# print "Chrome index is $HEADERS::CHROM\n";
# print "POS index is $HEADERS::POS\n";

my $test =  $SNPS[2]->FILTER();
print "$test\n";
# print "$ {$SNAPES[2]->FILTER}\n";

sub assign_headers
{
	package HEADERS;
	my @array = @{$_[0]};
	my $iter = 0;

	# check each array loop against known headers and assign the array index to header
	foreach (@array)
	{
    	if ($_ eq "CHROM")
    	{
    		our $CHROM = $iter;
    		# print "found CHROME! at index $CHROM\n";
    	};

    	if ($_ eq "POS")
    	{
    		our $POS = $iter;
    		# print "found POS! at index $iter\n"
    	};

    	if ($_ eq "ID")
    	{
    		our $ID = $iter;
    		# print "found POS! at index $iter\n"
    	};

    	if ($_ eq "REF")
    	{
    		our $REF = $iter;
    		# print "found POS! at index $iter\n"
    	};


    	if ($_ eq "ALT")
    	{
    		our $ALT = $iter;
    		# print "found POS! at index $iter\n"
    	};


    	if ($_ eq "QUAL")
    	{
    		our $QUAL = $iter;
    		# print "found POS! at index $iter\n"
    	};

    	if ($_ eq "FILTER")
    	{
    		our $FILTER = $iter;
    		# print "found POS! at index $iter\n"
    	};


    	if ($_ eq "INFO")
    	{
    		our $INFO = $iter;
    		# print "found POS! at index $iter\n"
    	};

    	if ($_ eq "FORMAT")
    	{
    		our $FORMAT = $iter;
    		# print "found POS! at index $iter\n"
    	};

    	$iter ++;
	};
};