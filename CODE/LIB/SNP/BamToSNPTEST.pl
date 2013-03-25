#!/usr/bin/perl
package LIB::SNP::BamToSNPTEST;

use strict;
use warnings;
use BamFillRestIn;
use SNP;

 my $SNP = new LIB::SNP::SNP();

 $SNP->CHROME(1);
 $SNP->POS(859560);

 LIB::SNP::BamFillRestIn->fill_rest_in(\$SNP);

 print "Heeeeere it comes!" . $SNP->INDEL() . "There it goes!";
