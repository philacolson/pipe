#!/usr/bin/perl

############################
#
#Module that fills in the rest of the SNP object that 
#was not filled in from the VCF/MAF file
#############################

package LIB::SNP::BamFillRestIn;

use strict;
use warnings;

use LIB::SNP::SNP;
use Bio::DB::Sam;
sub fill_rest_in {

	#what's with "self"?  I'm only passing one variable.
	my ($self,$fullFilePath,@SNPS) = @_;
	chomp($fullFilePath);
	open FH, '<', "$fullFilePath";


 my $sam = Bio::DB::Sam->new(-fasta=>"/Users/ph27168_ca/Desktop/chr1.fa",
                             -bam  =>"/Users/ph27168_ca/Desktop/higher.bam");

 my @alignments = $sam->get_features_by_location(-seq_id => '1',
                                                 -start  => 800000,
                                                 -end    => 900000);
	foreach (@SNPS){
		#this way will probably be best for speed.
		#if (not defined $_->ID or not defined $_->REF or not defined $_->ALT or not defined $_)
		#but it's horrendously ugly
		if (not defined $_->ID)
		{

		}
		if (not defined $_->REF)
		{

		}
		if (not defined $_->ALT)
		{
			
		}
	}

}