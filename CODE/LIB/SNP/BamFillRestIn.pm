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

#Start them all out as undefined, and whatever is changed will go to the SNP object.
my $VARPOS = undef;
my $VARID = undef;
my $VARREF = undef;
my $VARALT = undef;
my $VARQUAL = undef;
my $VARFILTER = undef;
my $VARINDEL= undef;
my $VARSTRAND = undef;

my prelimCountSNPCounter = 1;

my $callback = sub {
    my ($seqid,$pos,$pileup) = @_;

    our $indel;
        my $counts = @$pileup;
       
        foreach my $read (@$pileup)
        {
          $VARPOS = undef;
          $VARID = undef;
          $VARREF = undef;
          $VARALT = undef;
          $VARQUAL = undef;
          $VARFILTER = undef;
          $VARINDEL= undef;
          $VARSTRAND = undef;
                  #Set a couple of the fields.
          $VARPOS = $read->pos;        
          $VARID = $read->alignment->seq_id;
          $VARSTRAND = $read->alignment->strand;


        
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


	#Here, after the above function completes, we are scanning for any variable that has been filled in.  That SHOULD mean that the SNP object does not currently have an entry in that field.
  #So we are taking the variables that are defined and plugging them into the SNP object.  If they are not defined, then they are already filled in $SNP so don't overwrite them.
	$$SNP->POS($VARPOS) unless not defined ($VARPOS);
  $$SNP->ID($VARID) unless not defined ($VARID);
  $$SNP->REF($VARREF) unless not defined ($VARREF);
  $$SNP->ALT($VARALT) unless not defined ($VARALT);
  $$SNP->QUAL($VARQUAL) unless not defined ($VARQUAL);
  $$SNP->FILTER($VARFILTER) unless not defined ($VARFILTER);
  $$SNP->INDEL($VARINDEL) unless not defined ($VARINDEL);
  $$SNP->STRAND($VARSTRAND) unless not defined ($VARSTRAND);


  #print $$SNP->STRAND();
}


sub prelimCountSNPs{
  my shift($currSNP,$nextSNP) = @_;
  if ($$currSNP->POS() -ne $$nextSNP->POS())
  {
    prelimCountSNPCounter = 1;
  }
  else
  {
    prelimCountSNPCounter++;
  }
  $$nextSNP->COUNT(prelimCountSNPCounter);
}
