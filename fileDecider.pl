use strict;
use warnings;
my $file = $ARGV[0];


open my $FHa, '<', "$file";

my $firstLine = <$FHa>;
close $FHa;
print $firstLine;
if ($firstLine =~ m/VCF/)
{
	print "VCF";
system("perl ./vcf_reader.pl $ARGV[0]");
}

else
{
	print "MAF $file";
system("perl maf_reader.pl $file");
}