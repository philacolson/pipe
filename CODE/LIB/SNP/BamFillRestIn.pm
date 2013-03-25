#!/usr/bin/perl

############################
#
#Module that fills in the rest of the SNP object that 
#was not filled in from the VCF/MAF file
#############################

#The psuedocode of this is that it gets called by VCFReadWrite at a certain time, and takes in 
#
package LIB::SNP::BamFillRestIn;

use strict;
use warnings;
#use diagnostics;
use SNP;
use Bio::DB::Sam;

my $tempVar;

my $callback = sub {
    my ($seqid,$pos,$pileup) = @_;
   package main;
    our $indel;
        my $counts = @$pileup;
        
        #$positions++;
        #$depth += @$pileup;
        #each pileup object is the whole string of bps at that position
       
        foreach (@$pileup)
        {
            
         # $indel = Bio::DB::Sam->pileup()->INDEL();
      	$tempVar = $_->pos;        
      }
        # print "seq_id is " . $seq_id . " mseqid is " . $mseqid . " mend is " . $mend . " mstrand is " . $mstrand . " query dna is " . $query_dna . " read name is " . $read_name . "\n";
        # " strand is " $strand
    };

    
sub fill_rest_in
{

	#what's with "self"?  I'm only passing one variable.
	my ($self,$SNP) = @_;
print "$SNP";

 my $sam = Bio::DB::Sam->new(-fasta=>"/home/cory/Desktop/BAMfiles/chr1.fa",
                             -bam  =>"/home/cory/Desktop/BAMfiles/sample_Pooled-Ctrl.bam");


 #my @alignments = $sam->get_features_by_location(-seq_id => '1',
  #                                               -start  => 800000,
   #                                              -end    => 900000);
 	
	$sam->pileup("1:859560-859560",$callback);
	
	$$SNP->INDEL($tempVar);
}

