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
my $results = ();
if ($infile =~ /(\.[vcf]+)$/ || $infile =~ /(\.[VCF]+)$/)
{
	$results = LIB::SNP::VcfReadWrite->read_vcf($fullFilePath);
	$LIB::LOGGER::log->info("vcf file read into memory");
}
elsif ($infile =~ /(\.[maf]+)$/ || $infile =~ /(\.[MAF]+)$/)
{
	$results = LIB::SNP::MafReadWrite->read_maf($fullFilePath);
	$LIB::LOGGER::log->info("maf file read into memory");
}
else
{
	$LIB::LOGGER::log->logdie("incorrect input file type for fileNorm in paths.ini");
}

# read in the cancer vcf or maf location
my $infile2 = $paths->val('INPUT','FileCanc');
my $fullFilePath2 = "$source/$infile2";
if ($infile2 ne '')
{
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
}

# print out a val
my $test = $results->[2]->CHROME;
print "$test\n";

# change a val
$results->[2]->REF("C");

# confirm change
$test = $results->[2]->REF;
print "$test\n";

# ensure bad fields not present
# print out a val
if (defined $results->[2]->CENTER)
{
	my $test3 = $results->[2]->CENTER;
	print "$test3\n";
}

if (defined $results->[1]->ALT_COUNT_REV)
{
	my $test4 = $results->[1]->ALT_COUNT_REV;
	print "$test4\n";
}
