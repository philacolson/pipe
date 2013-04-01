#!/usr/bin/perl

###################################################
#
# Create the logger
#
###################################################

package LIB::LOGGER;

use strict;
use warnings;

use LIB::PATHS;

# make the logger configuration file
sub open_log() {
	# set the log level
	my $logLevel = $_[0];
	my $logFormat = $_[1];

	# get the timestamp
	open FH, "$LIB::PATHS::base_dir/CONFIG/timestamp.conf" or die $!;
	my $fullLogPath = do { local $/; <FH> };
	chomp($fullLogPath);
	close FH;

	# create a new log.conf file with our current parameters
	open FILEHANDLE, '>', "$base_dir/CONFIG/log.conf";

	print FILEHANDLE "log4perl.rootLogger=$logLevel, LOGFILE\n";
	print FILEHANDLE "log4perl.appender.LOGFILE=Log::Log4perl::Appender::File\n";
	print FILEHANDLE "log4perl.appender.LOGFILE.filename=$fullLogPath\n";
	print FILEHANDLE "log4perl.appender.LOGFILE.mode=append\n";
	print FILEHANDLE "log4perl.appender.LOGFILE.layout=PatternLayout\n";
	print FILEHANDLE "log4perl.appender.LOGFILE.layout.ConversionPattern=$logFormat";

	close (FILEHANDLE);
}

# create the logger
sub log_it() {
	use Log::Log4perl qw(get_logger);
    	Log::Log4perl->init("$LIB::PATHS::base_dir/CONFIG/log.conf");
	our $log = Log::Log4perl->get_logger("Logger");
	return \$log;
}

1;