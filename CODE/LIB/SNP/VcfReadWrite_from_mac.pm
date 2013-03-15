#!/usr/bin/perl

###################################################
#
# Module for reading in a vcf file and storing it
# in an array of SNP objects
#
###################################################

package LIB::SNP::VcfReadWrite;

use strict;
use warnings;

use LIB::SNP::SNP;

# reads a vcf file into an array of SNP objects and returns the array
sub read_vcf {

    # read in the file
    my ($self,$fullFilePath) = @_;
    chomp($fullFilePath);
    open FH, '<', "$fullFilePath"; 

    # create a flag to kickoff parsing each line once the line with the headers
    # is found.  Also need array of SNAPES.
    my $foundheaders = 0;
    my $snp_line = 0;
    my @SNPS;

    while (my $line = <FH>) {
    	# once you've found the headers, this will begin to kickoff
        if ($foundheaders == 1)
        {
            # get line elements and create a new SNAPE object using the elements
            # matched to the header index
            my @lineArray = split("\t", $line);
            my $SNP = new LIB::SNP::SNP();

            # set all the values.  Note that this could be done in a constructor
            ### Need to check to verify that that position exists before setting value
            if (defined $HEADERS::CHROM) { 
                $SNP->CHROME(@lineArray[$HEADERS::CHROM]); 
            }
            if (defined $HEADERS::POS) {
                $SNP->POS(@lineArray[$HEADERS::POS]);
            }
            if (defined $HEADERS::ID) {
                $SNP->ID(@lineArray[$HEADERS::ID]);
            }
            if (defined $HEADERS::REF) {
                $SNP->REF(@lineArray[$HEADERS::REF]);
            }
            if (defined $HEADERS::ALT) {
                $SNP->ALT(@lineArray[$HEADERS::ALT]);
            }
            if (defined $HEADERS::QUAL) {
                $SNP->QUAL(@lineArray[$HEADERS::QUAL]);
            }
            if (defined $HEADERS::FILTER) {
                $SNP->FILTER(@lineArray[$HEADERS::FILTER]);
            }

            # The info field can have multiple entries in it.  Need to separate them first.
            # Aribtrary fields will be ignored.  Filds without values will be ignored.
            # fields are arranged by two letter characters, sometimes = value, then a semi-colon as such:
            # NS=3;DP=14;AF=0.5;DB;H2
            if (defined $HEADERS::INFO) {
                my @infoArray = split(/;/);
                foreach (@infoArray)
                {
                    if ($_ =~ /[AA]/)
                    {
                        my $ancestralAllele = (split /\=/, $item)[1];
                    }
                    if ($_ =~ /[AC]/)
                    {
                        my $alleleCount = (split /\=/, $item)[1];
                    }
                    if ($_ =~ /[AF]/)
                    {
                        my $alleleFreq = (split /\=/, $item)[1];
                    }
                    if ($_ =~ /[AN]/)
                    {
                        my $numOfAlleles = (split /\=/, $item)[1];
                    }
                    if ($_ =~ /[BQ]/)
                    {
                        my $baseQual = (split /\=/, $item)[1];
                    }
                    if ($_ =~ /[CIGAR]/)
                    {
                        my $cigar = (split /\=/, $item)[1];
                    }
                    if ($_ =~ /[DP]/)
                    {
                        my $depth = (split /\=/, $item)[1];
                    }
                    if ($_ =~ /[END]/)
                    {
                        my $endPos = (split /\=/, $item)[1];
                    }
                    if ($_ =~ /[MQ]/)
                    {
                        my $RMSmappingQual = (split /\=/, $item)[1];
                    }
                    if ($_ =~ /[MQ0]/)
                    {
                        my $numMapQ0 = (split /\=/, $item)[1];
                    }
                    if ($_ =~ /[NS]/)
                    {
                        my $NumSamples = (split /\=/, $item)[1];
                    }
                    if ($_ =~ /[SB]/)
                    {
                        my $strandBias = (split /\=/, $item)[1];
                    }
                    # The most important field for analysis purposes is the I16 field
                    # it contains all the various counts needed for filtering.
                    # I16 stands for 16 integers, all comma delimited.
                    if ($_ =~ /[I16]/)
                    {
                        my @i16array = split(/,/, substr)
                    }

                }

            }

            # Add new SNP to the array
            push @SNPS, $SNP;
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

    return \@SNPS;
}

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

# write all the fields out to a new VCF file
sub write_vcf {

}

1;