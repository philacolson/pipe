#!/usr/bin/perl

###################################################
#
# Retrieve variables for the paths in ../../CONFIG/paths.ini
#
# a reference to the parms file is included in the output
# so that anything not explicity refenced, can be utilized
# using the following:
# my $var = $parms->val('HEADING','PARAMETER NAME')
#
###################################################

package LIB::PARMS;
use strict;
use warnings;

use Exporter;
our @ISA = 'Exporter';
our @EXPORT = qw($parms);

use Config::IniFiles;
use File::Copy;
use Cwd 'abs_path';
use Path::Class;

########## 
# note that the base directory could be retrieved by command
# use LIB::Paths
# but that would be including a library in a library which isn't
# good practice.
##########

# get the base directory for the code
my $full_file_path = abs_path($0);
my @parts = split('/', $full_file_path);
my $num_parts = scalar @parts;
my $base_dir = "";
# first element of array is empty, so don't use.
# from there, last element is script name then 'CODE'
# and the base directory will end at the element before that
for (my $elems = 1; $elems <= $num_parts - 3; $elems++)
{
	$base_dir = "$base_dir/$parts[$elems]";
}

our $parms = Config::IniFiles->new( -file => "$base_dir/CONFIG/parms.ini" );