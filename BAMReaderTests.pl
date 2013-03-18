#!/usr/bin/perl

###################################################
#
# Lets play with Bio::DB::Sam kiddies!!
#
###################################################

use Bio::DB::Sam;

# high level API
my $sam = Bio::DB::Sam->new(-bam  =>"/Users/ph27168_ca/Documents/TestBACKUP/BAM/sample_Pooled-Ctrl.bam",
                             -fasta=>"/Users/ph27168_ca/Documents/TestBACKUP/BAM/chr1.fa",
                             );

##### list of targets is rather strange, but this works.
##### then can insert them as a seq_id name
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

# while (@features) {

#    print "does it even start this loop?\n";

    # where does the alignment start in the reference sequence
    # my $seqid  = $_->seq_id;
    #print "seqid is $seqid\n";
    #my $start  = $_->start;
    #print "start is $start\n";
    #my $end    = $_->end;
    #print "end is $end\n";
    # my $strand = $_->strand;
    # print "strand is $strand\n";
# }


my $segment = $sam->segment(-seq_id=>'1',-start=>800000,-end=>900000);
##### length is as expected
my $newlength = $segment->length;
print "$newlength\n";
##### dna doesn't seem to print anything.
##### seq->seq prints "-id"
my $dna = $segment->dna;
# my $dna = $segment->seq->seq;
print "DNA strand is $dna\n";

##### so far get some gibberish for targets index 0, 1, and 3....
$sam->fetch("@targets[0]:0-1000000",
              sub {
                my $a = shift;
                print $a->display_name,' ',$a->cigar_str,' ',$a->pos,' ',$a->paired,"\n";
              });



print "does it finish?\n";