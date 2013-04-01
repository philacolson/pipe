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
my $REFCOUNTFWD = 0;
my $REFCOUNTREV = 0;
my $ALTCOUNTFWD = 0;
my $ALTCOUNTREV = 0;
my $ISINDEL = undef;
my $prelimCountSNPCounter = 1;
my $tempVar = undef;
my $depth = 0;

my $callback = sub {
    my ($seqid,$pos,$pileup) = @_;
$VARPOS = undef;
$VARID = undef;
$VARREF = undef;
$VARALT = undef;
$VARQUAL = undef;
$VARFILTER = undef;
$VARINDEL= undef;
$REFCOUNTFWD = 0;
$REFCOUNTREV = 0;
$ALTCOUNTFWD = 0;
$ALTCOUNTREV = 0;
$ISINDEL = undef;
$prelimCountSNPCounter = 1;
$tempVar = undef;

 
      
        my $counts = @$pileup;
       $depth = scalar(@$pileup);
        foreach my $read (@$pileup)
        {
          #print $tempVar . "\n";
          #Set a couple of the fields.
          #$VARPOS = $read->pos;        
          #print "This is the position " . $read->qpos;
          #print "That goes with this CIGAR" . $read->alignment->cigar_str;
          #If not an indel
        
          if ($read->indel != 0)
          {
          #then get alignment direction regardless of cancer or regular
          
            $ISINDEL = 1;
            #print "indel\n";
          }
          #If it is not an indel, mark it as such so the $SNP flag can be set
          else
          {
            $ISINDEL = 0;
            my $ref_dna = $read->alignment->dna;
            my $start = $read->alignment->start;
            my $query_dna = $read->alignment->query->dna;
            my $ref_char = substr($ref_dna,$pos-$start,1);
            my $query_char = substr($query_dna,$read->qpos,1);
            
            if ($ref_char ne $query_char)
            {
              if ($read->alignment->strand > 0)
              {
                $ALTCOUNTFWD++;
              }
              else
              {
                $ALTCOUNTREV++;
              }
            }
            else
            {
              if ($read->alignment->strand > 0)
              {
                $REFCOUNTFWD++;
              }
              else
              {
                $REFCOUNTREV++;
              }
            }
            #print $VARREFlocation . "\n";

          }
        }

};

    
sub fill_rest_in
{


	my ($self,$SNP,$range) = @_;


 my $sam = Bio::DB::Sam->new(-fasta=>"/Users/ph27168_ca/Desktop/chr1.fa",
                             -bam  =>"/Users/ph27168_ca/Desktop/sample_RS-00085920.bam");


 
 	$tempVar = $$SNP->POS();
	$sam->pileup($range,$callback);

  $$SNP->ISTUMOR(0);
	$$SNP->POS($VARPOS) unless not defined ($VARPOS);

  $$SNP->REF($VARREF) unless not defined ($VARREF);
  $$SNP->ALT($VARALT) unless not defined ($VARALT);

  $$SNP->FILTER($VARFILTER) unless not defined ($VARFILTER);
  $$SNP->INDEL($ISINDEL) unless not defined ($VARINDEL);
  if($$SNP->ISTUMOR() == 1)
  {
  $$SNP->REF_COUNT_TUMOR_FRWD($REFCOUNTFWD) unless not defined ($REFCOUNTFWD);
  $$SNP->REF_COUNT_TUMOR_REV($REFCOUNTREV) unless not defined ($REFCOUNTREV);
  $$SNP->ALT_COUNT_TUMOR_FRWD($ALTCOUNTFWD) unless not defined ($ALTCOUNTFWD);
  $$SNP->ALT_COUNT_TUMOR_REV($ALTCOUNTREV) unless not defined ($ALTCOUNTREV);
  }  
  else
  {
  $$SNP->REF_COUNT_FRWD($REFCOUNTFWD) unless not defined ($REFCOUNTFWD);
  $$SNP->REF_COUNT_REV($REFCOUNTREV) unless not defined ($REFCOUNTREV);
  $$SNP->ALT_COUNT_FRWD($ALTCOUNTFWD) unless not defined ($ALTCOUNTFWD);
  $$SNP->ALT_COUNT_REV($ALTCOUNTREV) unless not defined ($ALTCOUNTREV);
  }

print "The depth is " . $depth . "\n";
  #print $$SNP->POS();
  
}
