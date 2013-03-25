#!/usr/bin/perl

############################
#
#Module that fills in the rest of the SNP object that 
#was not filled in from the VCF/MAF file
#############################


package LIB::SNP::BamFillRestIn;

use strict;
use warnings;
#use diagnostics;
use LIB::SNP::SNP;
use Bio::DB::Sam;

my $VARPOS = undef;
my $VARID = undef;
my $VARREF = undef;
my $VARALT = undef;
my $VARQUAL = undef;
my $VARFILTER = undef;
my $VARINDEL= undef;
my $VARSTRAND = undef;

my $callback = sub {
    my ($seqid,$pos,$pileup) = @_;

    our $indel;
        my $counts = @$pileup;
        
        #$positions++;
        #$depth += @$pileup;
        #each pileup object is the whole string of bps at that position
       
        foreach my $read (@$pileup)
        {
            
        if (not defined($VARSTRAND))
        {
          print "All systems go, Strand is not defined";

        }
        else
        {
          print "No go, defined as " . $VARSTRAND;

        }
      	$VARPOS = $read->pos;        
        $VARID = $read->alignment->seq_id;

        $VARSTRAND = $read->alignment->strand;

        if (defined ($VARSTRAND))
        {
          print "Systems still go, defined as " . $VARSTRAND;
        }
        else
        {
          print "Uh oh, VARSTRAND is not defined"
        }
          }
      
    };

    
sub fill_rest_in
{

	
	my ($self,$SNP) = @_;


 my $sam = Bio::DB::Sam->new(-fasta=>"/Users/ph27168_ca/Desktop/chr1.fa",
                             -bam  =>"/Users/ph27168_ca/Desktop/sample_Pooled-Ctrl.bam");


 #my @alignments = $sam->get_features_by_location(-seq_id => '1',
  #                                               -start  => 800000,
   #                                              -end    => 900000);
 	
	$sam->pileup("1:859560-859560",$callback);
	
	$$SNP->POS($VARPOS) unless not defined ($VARPOS);
  $$SNP->ID($VARID) unless not defined ($VARID);
  $$SNP->REF($VARREF) unless not defined ($VARREF);
  $$SNP->ALT($VARALT) unless not defined ($VARALT);
  $$SNP->QUAL($VARQUAL) unless not defined ($VARQUAL);
  $$SNP->FILTER($VARFILTER) unless not defined ($VARFILTER);
  $$SNP->INDEL($VARINDEL) unless not defined ($VARINDEL);
  $$SNP->STRAND($VARSTRAND) unless not defined ($VARSTRAND);

  
  print $$SNP->STRAND();
}

