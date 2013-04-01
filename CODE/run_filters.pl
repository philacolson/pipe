#!/usr/bin/perl

###################################################
#
# Program that calls all specified filters
# At this point input/output should be verified  
#
###################################################

use strict;
use warnings;

use LIB::PATHS;
use LIB::PARMS;
use LIB::LOGGER;
use LIB::SNP::VcfReadWrite;
use LIB::SNP::MafReadWrite;
use LIB::SNP::BamFillRestIn;
# get path and level for log configuration file
my $logLevel = $parms->val('RUN_FILTERS','LogLevel');
my $logFormat = $parms->val('RUN_FILTERS','LogFormat');

# start up the log
&LIB::LOGGER::open_log($logLevel,$logFormat);
LIB::LOGGER::log_it();

$LIB::LOGGER::log->info("Beginning run_filters.pl script");

# read in the vcf or maf location
my $infile = $paths->val('INPUT','FileNorm');
my $source = $paths->val('INPUT','Source');
my $fullFilePath = "$source/$infile";

# load all object lines into an object called results
my $results;
if ($infile =~ /(\.[vcf]+)$/ || $infile =~ /(\.[VCF]+)$/)
{
	$results = LIB::SNP::VcfReadWrite->read_vcf($fullFilePath);
	#print @$results;
	$LIB::LOGGER::log->info("vcf file read into memory");
	my $testCounter = 0;
	foreach (@$results)
	{
		
		LIB::SNP::BamFillRestIn->fill_rest_in(\$$results[$testCounter], "1:39759200-39759200");
	    #LIB::SNP::BAMFillRestIn->does_nothing();
		#print $_->INDEL();
		#LIB::SNP::TEST->do_nothing;
		$testCounter++;
		print "For SNP: $testCounter :" . $_->REF_COUNT_FRWD() . " is Ref forward\n";
		print $_->REF_COUNT_REV() . " Is ref reverse\n";
		print $_->ALT_COUNT_FRWD() . "Is the alt count frwd \nand " . $_->ALT_COUNT_REV() . " is ALT_COUNTREV\n";
	}

#foreach (@$results)
#{
#	print $_->COUNT();
#}
}
elsif ($infile =~ /(\.[maf]+)$/ || $infile =~ /(\.[MAF]+)$/)
{
	$results = LIB::SNP::MafReadWrite->read_maf($fullFilePath);
	$LIB::LOGGER::log->info("normal maf file read into memory");
}
else
{
	$LIB::LOGGER::log->logdie("incorrect input file type for fileNorm in paths.ini");
}

# read in the cancer vcf or maf location
my $infile2 = $paths->val('INPUT','FileCanc');
my $fullFilePath2 = "$source/$infile2";

	if ($infile2 =~ /(\.[vcf]+)$/ || $infile2 =~ /(\.[VCF]+)$/)
	{

	}
	elsif ($infile2 =~ /(\.[maf]+)$/ || $infile2 =~ /(\.[MAF]+)$/)
	{

	}
	else
	{
		$LIB::LOGGER::log->logdie("cancer input file not a vcf or maf file");
	}
if ($infile2 =~ /(\.[vcf]+)$/ || $infile2 =~ /(\.[VCF]+)$/)
{
	# note that this overwrites the initial SNPS array rather than append.
	# however, the alternative would be write an array sorting routine afterwards which is
	# easily as messy.
	$results = LIB::SNP::VcfReadWrite->read_tumor($fullFilePath2,\$results);
	$LIB::LOGGER::log->info("tumor vcf file read into memory");
}
elsif ($infile2 =~ /(\.[maf]+)$/ || $infile2 =~ /(\.[MAF]+)$/)
{
	### add in MAF caller
}
else
{
	$LIB::LOGGER::log->logdie("tumor input file not a vcf or maf file");
}




# ensure bad fields not present
# print out a val
if (defined $results->[2]->CENTER)
{my $test3 = $results->[2]->CENTER;
	print "$test3\n";
my $i = 0;
foreach (@$results)
{
	#print "@$results->[$i]->POS\n";
	if ($results->[$i]->POS == 1718619)
	{
		my $test5 = $results->[$i]->REF_COUNT_TUMOR_FRWD;
		my $test6 = $results->[$i]->REF_COUNT_FRWD;
		#print "Ref Tumor Fwd $test5\n";
		#print "Ref Norm Fwd $test6\n";
	}
	$i++;
	
}
}
