use Bio::DB::Sam;

# high level API
my $sam = Bio::DB::Sam->new(-bam  =>"/Users/ph27168_ca/Documents/TestBACKUP/BAM/sample_Pooled-Ctrl.bam",
                             -fasta=>"/Users/ph27168_ca/Documents/TestBACKUP/BAM/chr1.fa",
                             );

my @alignments = $sam->get_features_by_location(-seq_id => '1',
	-start => 800000,
	-end => 900000);

for my $a (@alignments) {
	my $seqid = $a->seq_id;
	my $start = $a->start;
	my $end = $a->end;
	my $strand = $a->strand;
	my $ref_dna = $a->dna;

	my $query_start = $a->query->start;
	my $query_end = $a->query->end;
	my $query_strand = $a->query->strand;
    my $query_dna    = $a->query->dna;
   
    my $cigar     = $a->cigar_str;
    my @scores    = $a->qscore;     # per-base quality scores
    my $match_qual= $a->qual; 

   print $seqid;
}
#my $coverage = $sam->features(-type=>'coverage',-seq_id=>'1');
#my @data = $coverage->coverage;
#my $total;
#for (@data) {$total += $_}
#my $average_coverage = $total/@data;
#print $average_coverage;