#!/usr/bin/perl

############################
#
#Module that fills in the rest of the SNP object that 
#was not filled in from the VCF/MAF file
#############################

#The psuedocode of this is that it gets called by VCFReadWrite at a certain time, and takes in 
#
package LIB::SNP::BAMFillRestIn;

use strict;
use warnings;
#use diagnostics;
use LIB::SNP::SNP;
use Bio::DB::Sam;
my %tempVar=(
  id => undef,
  indel => undef,
  );

#called from fill_rest_in via a strange method-within-method call.  
#Takes in: The sequence ID, Position, and the pileup object.
#Loops through the pileup object RIGHT NOW IT ONLY HANDLES ONE POSITION and places 
#and stores the SNP value in $tempVar for fill_rest_in to access.
my $callback = sub 
{
	
    my ($seqid,$pos,$pileup) = @_;
  
    our $indel;
        my $counts = @$pileup;
        
       
        #each pileup object is the whole string of bps at that position
       #For every SNP entry here, check if a needed field is not defined
       #if it's not defined, we need to fill it in with the bam file but we .
       #need to know which ones are undefined. 
        foreach (@$pileup)
        {
            
          if (not defined ($tempVar{id}))
            {
            	#print $_->seq_id;
              #$tempVar{id} = $_->seq_id;
            }
          if (not defined ($tempVar{indel}))
            {
              $tempVar{indel} = $_->indel;
            }
      	#$tempVar = $_->pos;        
        }
        
};

    
sub fill_rest_in {

	my ($self,$SNP) = @_;
#print $SNP;

 my $sam = Bio::DB::Sam->new(-fasta=>"/Users/ph27168_ca/Desktop/chr1.fa",
                             -bam  =>"/Users/ph27168_ca/Desktop/sample_Pooled-Ctrl.bam");


 #my @alignments = $sam->get_features_by_location(-seq_id => '1',
  #                                               -start  => 800000,
   #                                              -end    => 900000);
 	
  #For optimization, preset the values we already have in the hash.
  my $tempString = $$SNP->POS();
  print $tempString . "\n\n\n";
  #$tempVar{id} = $tempString;
  #$tempVar{indel} = $$SNP->INDEL();
	

  #Find out what is not defined still
  $sam->pileup("1:859560-859560",$callback);
	#if we're having trouble getting multiple positions, we can try doing a separate sub

  #Now that we have the hash filled with everything, let's fill in the rest of the SNP
  if (defined ($tempVar{id}))
  {
    $$SNP->ID($tempVar{id});
  }
  if (defined ($tempVar{indel}))
  {
	  $$SNP->INDEL($tempVar{indel});
  }
  print "Chromosome is " . $$SNP->CHROME() . "Position is " . $$SNP->POS() . "ID is " . $$SNP->ID() . "Indel is " . $$SNP->INDEL() . "\n\n";
}

1;
