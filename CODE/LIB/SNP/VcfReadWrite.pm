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

use LIB::PATHS;
use LIB::PARMS;
use LIB::SNP::SNP;
use LIB::LOGGER;

# get path and level for log configuration file
my $logLevel = $parms->val('VCF','LogLevel');
my $logFormat = $parms->val('VCF','LogFormat');

# start up the log
&LIB::LOGGER::open_log($logLevel,$logFormat);
LIB::LOGGER::log_it();

# reads a vcf file into an array of SNP objects and returns the array
sub read_vcf 
{
    $LIB::LOGGER::log->info("Beginning read_vcf function");

    # read in the file
    my ($self,$fullFilePath) = @_;
    chomp($fullFilePath);
    open FH, '<', "$fullFilePath"; 

    # create a flag to kickoff parsing each line once the line with the headers
    # is found.  Also need array of SNPS.
    my $foundheaders = 0;
    my @SNPS;

    while (my $line = <FH>) 
    {
    	# once you've found the headers, this will begin to kickoff
        if ($foundheaders == 1)
        {
            # get line elements and create a new SNP object using the elements
            # matched to the header index
            my @lineArray = split("\t", $line);
            my $SNP = new LIB::SNP::SNP();

            # set all the values.  Note that this could be done in a constructor
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
                # may need to split this into a hash if multiple alt alleles.
                # deal with X values where there is no alt
                $SNP->ALT(@lineArray[$HEADERS::ALT]);
            }
            if (defined $HEADERS::QUAL) {
                $SNP->QUAL(@lineArray[$HEADERS::QUAL]);
            }
            if (defined $HEADERS::FILTER) {
                $SNP->FILTER(@lineArray[$HEADERS::FILTER]);
            }

            # The info field can have multiple entries in it.  Need to separate them first.
            # Aribtrary fields will be ignored.  Fields without values will be ignored.
            # Fields are arranged by two letter characters, sometimes = value, then a semi-colon as such:
            # NS=3;DP=14;AF=0.5;DB;H2
            if (defined $HEADERS::INFO) 
            {
                my @infoArray = split(';',@lineArray[$HEADERS::INFO]);
                foreach my $infoString (@infoArray)
                {
                    # print "this is $infoString\n";
                    if ($infoString =~ /DP/)
                    {
                        # print "this is DP $infoString\n";
                        my @cov = split('=',$infoString);
                        # this may not be the depth we desire
                        $SNP->COV($cov[1]);
                    }
                    # parse the I16 data field
                    if ($infoString =~ /I16/)
                    {
                        #print "this is I16 $infoString\n";

                        my @i16array = split(/[=,]/, $infoString);
                        #print "$i16array[1]\n";
                        $SNP->REF_COUNT_FRWD($i16array[1]);
                        $SNP->REF_COUNT_REV($i16array[2]);
                        $SNP->ALT_COUNT_FRWD($i16array[3]);
                        $SNP->ALT_COUNT_REV($i16array[4]);
                    }
                    if ($infoString =~ /INDEL/)
                    {
                        # will have to see the format of this
                        $SNP->INDEL(1);
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

# reads a vcf file in and either updates a current SNP object or creates a new one
# if the position was not found.
sub read_tumor
{
    # read in the file
    my ($self,$fullFilePath,$SNPSin) = @_;
    chomp($fullFilePath);
    open FH, '<', "$fullFilePath"; 

    # create a flag to kickoff parsing each line once the line with the headers
    # is found.  Also need array of SNPS.
    my $foundheaders = 0;
    my @SNPS;

    # create an array listing all the current SNP positions
    # will need this to search through for matches with the new file
    my @pos_array;
    my $i = 0;
    foreach (@$$SNPSin)
    {
        $pos_array[$i] = $$$SNPSin[$i]->POS;
        $i++;
    }     

    my $orig_index = 0;
    my $cur_index = 0;
    # grab a new line from the cancer vcf file
    while (my $line = <FH>) 
    {
        # once you've found the headers, this will begin to kickoff
        if ($foundheaders == 1)
        {
            # get line elements and create a new SNP object using the elements
            # matched to the header index
            my @lineArray = split("\t", $line);
            # assume POS exists.  If not we're going to have issues anyway
            my $cur_pos = @lineArray[$HEADERS::POS];

            # need to store all the lower indexed positions that don't exist
            # in this file into the array first to keep it ordered
            while ($cur_pos > $pos_array[$orig_index])
            {
                # print "cur_pos is $cur_pos and pos_array is $pos_array[$orig_index]\n";
                # print "these positions only found in reference $pos_array[$orig_index]\n";
                push @SNPS, $$$SNPSin[$orig_index];
                $orig_index++;
            }

            # if the positions match store only the new information
            if ($cur_pos == $pos_array[$orig_index])
            {
                # print "positions are the same at $cur_pos\n";
                # for now assuming all shared fields are already filled in and the same
                if (defined $HEADERS::INFO) 
                {
                    my @infoArray = split(';',@lineArray[$HEADERS::INFO]);
                    foreach my $infoString (@infoArray)
                    {
                        # assuming for now that all shared fields are already populated
                        # and are the same.  Only populating new fields.

                        # parse the I16 data field
                        if ($infoString =~ /I16/)
                        {
                            #print "this is I16 $infoString\n";

                            my @i16array = split(/[=,]/, $infoString);

                            $$$SNPSin[$orig_index]->REF_COUNT_TUMOR_FRWD($i16array[1]);
                            $$$SNPSin[$orig_index]->REF_COUNT_TUMOR_REV($i16array[2]);
                            $$$SNPSin[$orig_index]->ALT_COUNT_TUMOR_FRWD($i16array[3]);
                            $$$SNPSin[$orig_index]->ALT_COUNT_TUMOR_REV($i16array[4]);
                        }
                    }
                }
                push @SNPS, $$$SNPSin[$orig_index];
                $orig_index++;
            }
            # if the position is less, simply create the new SNP object and push it
            else
            {
                # print "these positions only found in tumor @lineArray[$HEADERS::POS]\n";
                my $SNP = new LIB::SNP::SNP();

                # set all the values.  Note that this could be done in a constructor
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
                    # may need to split this into a hash if multiple alt alleles.
                    # deal with X values where there is no alt
                    $SNP->ALT(@lineArray[$HEADERS::ALT]);
                }
                if (defined $HEADERS::QUAL) {
                    $SNP->QUAL(@lineArray[$HEADERS::QUAL]);
                }
                if (defined $HEADERS::FILTER) {
                    $SNP->FILTER(@lineArray[$HEADERS::FILTER]);
                }

                # The info field can have multiple entries in it.  Need to separate them first.
                # Aribtrary fields will be ignored.  Fields without values will be ignored.
                # Fields are arranged by two letter characters, sometimes = value, then a semi-colon as such:
                # NS=3;DP=14;AF=0.5;DB;H2
                if (defined $HEADERS::INFO) 
                {
                    my @infoArray = split(';',@lineArray[$HEADERS::INFO]);
                    foreach my $infoString (@infoArray)
                    {
                        # print "this is $infoString\n";
                        if ($infoString =~ /DP/)
                        {
                            # print "this is DP $infoString\n";
                            my @cov = split('=',$infoString);
                            # this may not be the depth we desire
                            $SNP->COV($cov[1]);
                        }
                        # parse the I16 data field
                        if ($infoString =~ /I16/)
                        {
                            #print "this is I16 $infoString\n";

                            my @i16array = split(/[=,]/, $infoString);
                            #print "$i16array[1]\n";
                            $SNP->REF_COUNT_TUMOR_FRWD($i16array[1]);
                            $SNP->REF_COUNT_TUMOR_REV($i16array[2]);
                            $SNP->ALT_COUNT_TUMOR_FRWD($i16array[3]);
                            $SNP->ALT_COUNT_TUMOR_REV($i16array[4]);
                        }
                        if ($infoString =~ /INDEL/)
                        {
                            # will have to see the format of this
                            $SNP->INDEL(1);
                        }
                    }
                }
                # Add new SNP to the array
                push @SNPS, $SNP;
            }
        }

        # Search for line with "#C" at the beginning.  This will contain the headers
        if ($line =~ m/#C/ ) 
        {
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
sub write_vcf 
{

}

1;