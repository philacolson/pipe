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
if 
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
		$SNP->ENTREZ(@lineArray[$HEADERS::Entrez_Gene_Id]);
        $SNP->CENTER(@lineArray[$HEADERS::Center]);
        $SNP->TCGAID(@lineArray[$HEADERS::NCBI_Build]);
        $SNP->POS(@lineArray[$HEADERS::Start_Position]);
        $SNP->CHROM(@lineArray[$HEADERS::Chromosome]);
        $SNP->STARTER(@lineArray[$HEADERS::Start_Position]);
        $SNP->ENDER(@lineArray[$HEADERS::End_Position]);
        $SNP->STRAND(@lineArray[$HEADERS::Strand]);
        $SNP->VARIANTCLASS(@lineArray[$HEADERS::Variant_Classification]);
        $SNP->VARIANTTYPE(@lineArray[$HEADERS::Variant_Type]);
	$SNP->REFALLELE(@lineArray[$HEADERS::Referene_Allele]);
        $SNP->TUMORSEQALLELE1(@lineArray[$HEADERS::Tumor_Seq_Allele1]);
        $SNP->TUMORSEQALLELE2(@lineArray[$HEADERS::Tumor_Seq_Allele2]);
        $SNP->DBSNP(@lineArray[$HEADERS::dbSNP_RS]);
        $SNP->DBSNPVALIDSTATUS(@lineArray[$HEADERS::dbSNP_Val_Status]);
        $SNP->TUMORBARCODE(@lineArray[$HEADERS::Tumor_Sample_Barcode]);
        $SNP->MATCHEDNORMSAMPLEBARCODE(@lineArray[$HEADERS::Matched_Norm_Sample_Barcode]);
        $SNP->MATCHNORMSEQALLELE1(@lineArray[$HEADERS::Match_Norm_Seq_Allele1]);
        $SNP->MATCHNORMSEQALLELE2(@lineArray[$HEADERS::Match_Norm_Seq_Allele2]);
        $SNP->TUMORVALIDALLELE1(@lineArray[$HEADERS::Tumor_Validation_Allele1]);
        $SNP->TUMORVALIDALLELE2(@lineArray[$HEADERS::Tumor_Validation_Allele2]);
        $SNP->MATCH_NORM_VALID_ALLELE1(@lineArray[$HEADERS::Match_Norm_Validation_Allele1]);
        $SNP->MATCH_NORM_VALID_ALLELE2(@lineArray[$HEADERS::Match_Norm_Validation_Allele2]);
        $SNP->VERIFICATIONSTATUS(@lineArray[$HEADERS::Verification_Status]);
        $SNP->VALIDATIONSTATUS(@lineArray[$HEADERS::Validation_Status]);
        $SNP->MUTATIONSTATUS(@lineArray[$HEADERS::Mutation_Status]);
        $SNP->SEQPHASE(@lineArray[$HEADERS::Sequencing_Phase]);
        $SNP->SEQSOURCE(@lineArray[$HEADERS::Sequence_Source]);
        $SNP->VALIDATIONMETHOD(@lineArray[$HEADERS::Validation_Method]);
        $SNP->SEQUENCER(@lineArray[$HEADERS::Sequencer]);
        $SNP->TUMORSAMPLEUUID(@lineArray[$HEADERS::Tumor_Sample_UUID]);
        $SNP->MATCHNORMSAMPLEUUID(@lineArray[$HEADERS::Matched_Norm_Sample_UUID]);
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
    my @headers=("ENTREZ", "CENTER", "TCGAID", "POS", "CHROM", "STARTER", "ENDER", "STRAND", "VARIANTCLASS", "VARIANTTYPE", "REFALLELE", "TUMORSEQALLELE1", "TUMORSEQALLELE2", "DBSNP", "DBSNPVALIDSTATUS", "TUMORBARCODE", "MATCHEDNORMSAMPLEBARCODE", "MATCHNORMSEQALLELE1", "MATCHNORMSEQALLELE2", "TUMORVALIDALLELE1", "TUMORVALIDALLELE2", "MATCH_NORM_VALID_ALLELE1", "MATCH_NORM_VALID_ALLELE2", "VERIFICATIONSTATUS", "VALIDATIONSTATUS", "MUTATIONSTATUS", "SEQPHASE", "SEQSOURCE", "VALIDATIONMETHOD", "SEQUENCER", "TUMORSAMPLEUUID", "MATCHNORMSAMPLEUUID");
	my $iter = 0;

	# check each array loop against known headers and assign the array index to header
####If you get it reading stuff in, you can delete this code.
    #	if ($_ eq "CHROM")
    #	{
    #		our $CHROM = $iter;
    		# print "found CHROME! at index $CHROM\n";
    #	};

    	
};
