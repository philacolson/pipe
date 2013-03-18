use Bio::DB::Sam;

# high level API
my $sam = Bio::DB::Sam->new(-bam  =>"/Users/ph27168_ca/Documents/TestBACKUP/BAM/sample_Pooled-Ctrl.bam",
                             -fasta=>"/Users/ph27168_ca/Documents/TestBACKUP/BAM/chr1.fa",
                             );
my @targets    = $sam->seq_ids;
print "@targets\n";

my $num_targets = $sam->n_targets;
print "$num_targets\n";

##### length is 198022430, prob chromosome 3
my $length = $sam->length('3');
print "$length\n";

my $seq_id = $sam->target_name(2);
print "$seq_id\n";

##### clearly gets a bunch of features, but then can't seem to
##### exract anything from them.
my @features = $sam->get_features_by_location("80791");
my $arraySize = @features;
print scalar @features;
print "\n";
my ($coverage) = $sam->features(-type=>'coverage',-seq_id=>'1',-start  => 800000,-end    => 890000);
 my @data       = $coverage->coverage;
 my $total;
 for (@data) { $total += $_ }
 my $average_coverage = $total/@data;
 print "ave cov is: $average_coverage and total cov is $total\n";