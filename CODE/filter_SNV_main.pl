#!/usr/bin/perl

###################################################
#
# Driver program for SNV gene filtering
#
###################################################

use strict;
use warnings;

use LIB::PATHS;
use LIB::PARMS;
use LIB::LOGGER;

# check for valid output directory.  This must be done before logging
# since the log will go into the output directory and can't be written
# to without it.
if (! -d "$output_dir") {
	print "Output directory $output_dir does not exist\n";
	print "Please check OutputDir value under OUTPUT in paths.ini and rerun\n";
	print "Program exiting\n";
	exit 1;
}

# create LOG directory in OUTPUT unless already exists
mkdir "$output_dir/$log_dir" unless -d "$output_dir/$log_dir";

# name log file with timestamp
my @now = localtime();
our $timeStamp = sprintf("%04d_%02d%02d_%02d%02d%02d", 
                        $now[5]+1900, $now[4]+1, $now[3],
                        $now[2],      $now[1],   $now[0]);

my $logFile = "$timeStamp.log";
my $fullLogPath = $output_dir . "/" . $log_dir . "/" . $logFile;
qx(touch $fullLogPath);

# write timestamp out to a file
open FH, '>', "$base_dir/CONFIG/timestamp.conf";
print FH "$fullLogPath\n";
close FH;

# get path and level for log configuration file
my $logLevel = $parms->val('MAIN','LogLevel');
my $logFormat = $parms->val('MAIN','LogFormat');

# start up the log
&LIB::LOGGER::open_log($logLevel,$logFormat);
LIB::LOGGER::log_it();
   
$LIB::LOGGER::log->fatal("Beginning of Log");

### Check for proper input
if (! -d "$source_dir") {
	print "Input directory $source_dir does not exist\n";
	print "Please check Source value under INPUT in paths.ini and rerun\n";
	print "Program exiting\n";
	$LIB::LOGGER::log->error("Input File directory not valid");
	exit 1;
}
else {
	opendir(D, "$source_dir") || die $LIB::LOGGER::log->logdie();
	my @input_list = readdir(D);
	closedir(D);

	### need some kind of markers for what files we're supposed to have
	my $high = "high";
	my $low = "low";
	### use this if we have literal filenames
	#unless (-e $filename) {
 	#	print "File Doesn't Exist!";
 	#} 
}

# begin running filters
my $script_loc2 = "$base_dir" . "/CODE/run_filters.pl";
system("/usr/bin/perl $script_loc2");