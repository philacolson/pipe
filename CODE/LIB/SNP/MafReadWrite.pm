#!/usr/bin/perl

###################################################
#
# Test reader for maf file
#
###################################################

package LIB::SNP::MafReadWrite;

use strict;
use warnings;

use LIB::SNP::SNP;

sub read_maf {

    # read in the file
    my ($self,$fullFilePath) = @_;
    chomp($fullFilePath);
    open FH, '<', "$fullFilePath"; 

    # create a flag to kickoff parsing each line once the line with the headers
    # is found.  Also need array of SNPs.
    my $foundheaders = 0;
    my $snp_line = 0;
    my @SNPS = ();

    while (my $line = <FH>) {
	# once you've found the headers, this will begin to kickoff
	
	
        if ($line =~ m/#/) {
		#Irrelevant, non-SNP information
        }
        elsif ($line =~ m/HUGO_SYMBOL/){
            #Headers already taken care of
        }
        else 
        {
            # get line elements and create a new SNP object using the elements
            # matched to the header index
            my @lineArray = split("\t", $line);
            my $SNP = new LIB::SNP::SNP();

            # set all the values.  Note that this could be done in a constructor
            ### Need to check to verify that that position exists before setting value
            $SNP->ENTREZ($lineArray[0]);
            $SNP->CENTER($lineArray[1]);
            $SNP->TCGAID($lineArray[2]);
            $SNP->POS($lineArray[3]);
            $SNP->CHROME($lineArray[4]);
            $SNP->STARTER($lineArray[5]);
            $SNP->ENDER($lineArray[6]);
            $SNP->STRAND($lineArray[7]);
            $SNP->VARIANTCLASS($lineArray[8]);
            $SNP->VARIANTTYPE($lineArray[9]);
            $SNP->REFALLELE($lineArray[10]);
            $SNP->TUMORSEQALLELE1($lineArray[11]);
            $SNP->TUMORSEQALLELE2($lineArray[12]);
            $SNP->DBSNP($lineArray[13]);
            #comment
            $SNP->DBSNPVALIDSTATUS($lineArray[14]);
            $SNP->TUMORBARCODE($lineArray[15]);
            $SNP->MATCHEDNORMSAMPLEBARCODE($lineArray[16]);
            $SNP->MATCHNORMSEQALLELE1($lineArray[17]);
            $SNP->MATCHNORMSEQALLELE2($lineArray[18]);
            $SNP->TUMORVALIDALLELE1($lineArray[19]);
            $SNP->TUMORVALIDALLELE2($lineArray[20]);
            $SNP->MATCH_NORM_VALID_ALLELE1($lineArray[21]);
            $SNP->MATCH_NORM_VALID_ALLELE2($lineArray[22]);
            $SNP->VERIFICATIONSTATUS($lineArray[23]);
            $SNP->VALIDATIONSTATUS($lineArray[24]);
            $SNP->MUTATIONSTATUS($lineArray[25]);
            $SNP->SEQPHASE($lineArray[26]);
            $SNP->SEQSOURCE($lineArray[27]);
            $SNP->VALIDATIONMETHOD($lineArray[28]);
            $SNP->SEQUENCER($lineArray[29]);
            $SNP->TUMORSAMPLEUUID($lineArray[30]);
            $SNP->MATCHNORMSAMPLEUUID($lineArray[31]);
            # Add new SNP to the array
            $SNPS[$snp_line] = $SNP;
            $snp_line ++;
        };

    };
    close FH;
    return \@SNPS;
};

# print "Chrome index is $HEADERS::CHROM\n";
# print "POS index is $HEADERS::POS\n";

# my $test =  $SNPS[2]->ENTREZ();
# print "In MAFREADER $test\n";
# print "$ {$SNAPES[2]->FILTER}\n";

#sub assign_headers
#{
#	package HEADERS;
#	my @array = @{$_[0]};
#    my @headers=("ENTREZ", "CENTER", "TCGAID", "POS", "CHROM", "STARTER", "ENDER", "STRAND", "VARIANTCLASS", "VARIANTTYPE", "REFALLELE", "TUMORSEQALLELE1", "TUMORSEQALLELE2", "DBSNP", "DBSNPVALIDSTATUS", "TUMORBARCODE", "MATCHEDNORMSAMPLEBARCODE", "MATCHNORMSEQALLELE1", "MATCHNORMSEQALLELE2", "TUMORVALIDALLELE1", "TUMORVALIDALLELE2", "MATCH_NORM_VALID_ALLELE1", "MATCH_NORM_VALID_ALLELE2", "VERIFICATIONSTATUS", "VALIDATIONSTATUS", "MUTATIONSTATUS", "SEQPHASE", "SEQSOURCE", "VALIDATIONMETHOD", "SEQUENCER", "TUMORSAMPLEUUID", "MATCHNORMSAMPLEUUID");
#	my $iter = 0;
    	
#};

1;