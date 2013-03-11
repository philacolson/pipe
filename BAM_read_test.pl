#!/usr/bin/perl

###################################################
#
# Lets play with Bio::DB::Sam kiddies!!
#
###################################################

use Bio::DB::Sam;

# high level API
my $sam = Bio::DB::Sam->new(-bam  =>"/Users/coryprzybyla/Desktop/BuffaloRA/TEST_SCRIPTS/VCF/BAMfiles/sample_Pooled-Ctrl.bam",
                             -fasta=>"/Users/coryprzybyla/Desktop/BuffaloRA/TEST_SCRIPTS/VCF/BAMfiles/chr1.fa",
                             );

my @targets    = $sam->seq_ids;
my @alignments = $sam->get_features_by_location(-seq_id => 'seq2',
                                                 -start  => 500,
                                                 -end    => 800);
for my $a (@alignments) {

    # where does the alignment start in the reference sequence
    my $seqid  = $a->seq_id;
    my $start  = $a->start;
    my $end    = $a->end;
    my $strand = $a->strand;
    my $cigar  = $a->cigar_str;
    my $paired = $a->get_tag_values('PAIRED');

    # where does the alignment start in the query sequence
    my $query_start = $a->query->start;     
    my $query_end   = $a->query->end;

    my $ref_dna   = $a->dna;        # reference sequence bases
    my $query_dna = $a->query->dna; # query sequence bases

    my @scores    = $a->qscore;     # per-base quality scores
    my $match_qual= $a->qual;       # quality of the match
 }

  my @pairs = $sam->get_features_by_location(-type   => 'read_pair',
                                            -seq_id => 'seq2',
                                            -start  => 500,
                                            -end    => 800);

 for my $pair (@pairs) {
    my $length                    = $pair->length;   # insert length
    my ($first_mate,$second_mate) = $pair->get_SeqFeatures;
    my $f_start = $first_mate->start;
    my $s_start = $second_mate->start;
 }

 # low level API
 my $bam          = Bio::DB::Bam->open('/path/to/bamfile');
 my $header       = $bam->header;
 my $target_count = $header->n_targets;
 my $target_names = $header->target_name;
 while (my $align = $bam->read1) {
    my $seqid     = $target_names->[$align->tid];
    my $start     = $align->pos+1;
    my $end       = $align->calend;
    my $cigar     = $align->cigar_str;
 }

 my $index = Bio::DB::Bam->index_open('/path/to/bamfile');
 my $index = Bio::DB::Bam->index_open_in_safewd('/path/to/bamfile');

 my $callback = sub {
     my $alignment = shift;
     my $start       = $alignment->start;
     my $end         = $alignment->end;
     my $seqid       = $target_names->[$alignment->tid];
     print $alignment->qname," aligns to $seqid:$start..$end\n";
 }
 my $header = $index->header;
 $index->fetch($bam,$header->parse_region('seq2'),$callback);