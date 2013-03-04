#!/usr/bin/perl

###################################################
#
# Retrieve variables for the paths in ../../CONFIG/paths.ini
#
# a reference to the paths file is included in the output
# so that anything not explicity refenced, can be utilized
# using the following:
# my $var = $paths->val('HEADING','PARAMETER NAME')
#
###################################################

package LIB::PATHS;
use strict;
use warnings;

use Exporter;
our @ISA = 'Exporter';
our @EXPORT = qw($paths $base_dir $source_dir $output_dir $log_dir);

use Config::IniFiles;
use File::Copy;
use Cwd 'abs_path';
use Path::Class;

# get the base directory for the code
my $full_file_path = abs_path($0);
my @parts = split('/', $full_file_path);
my $num_parts = scalar @parts;
our $base_dir = "";
# first element of array is empty, so don't use.
# from there, last element is script name then 'CODE'
# and the base directory will end at the element before that
for (my $elems = 1; $elems <= $num_parts - 3; $elems++)
{
	$base_dir = "$base_dir/$parts[$elems]";
}

# read in config files
our $paths = Config::IniFiles->new( -file => "$base_dir/CONFIG/paths.ini" );

# read in paths
our $source_dir = $paths->val('INPUT','Source');
our $output_dir = $paths->val('OUTPUT','OutputDir');
our $log_dir = $paths->val('OUTPUT','LogDir');