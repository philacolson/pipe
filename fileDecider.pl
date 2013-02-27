use strict;
use warnings;

open $FH, '<', "$ARGV[0]";

my $firstLine = <$FH>;
close $FH;

if ($firstLine =~ m/VCF/)
{
#ship off to vcf_reader
}

else
{
	#ship off to maf_reader
}