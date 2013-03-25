#!/usr/bin/perl

package LIB::SNP::SNP;
 
use strict;
use warnings;

sub new {
    my $self = {};
    # main vcf populated fields
    $self->{CHROME} = undef;
    $self->{POS}    = undef;
    $self->{ID}     = undef;
    $self->{REF}    = undef;
    $self->{ALT}    = undef;
    $self->{QUAL}   = undef;
    $self->{FILTER} = undef;

    #i16 or info vcf populated fields
    $self->{REF_COUNT_FRWD} = undef;
    $self->{REF_COUNT_REV} = undef;
    $self->{ALT_COUNT_FRWD} = undef;
    $self->{ALT_COUNT_REV} = undef;
    $self->{REF_COUNT_TUMOR_FRWD} = undef;
    $self->{REF_COUNT_TUMOR_REV} = undef;
    $self->{ALT_COUNT_TUMOR_FRWD} = undef;
    $self->{ALT_COUNT_TUMOR_REV} = undef;
    $self->{COV} = undef;
    $self->{INDEL} = undef;

    $self->{ENTREZ} = undef;
    $self->{CENTER} = undef;
    $self->{TCGAID} = undef;
    $self->{STARTER} = undef;
    $self->{ENDER} = undef;
    $self->{STRAND} = undef;
    $self->{VARIANTCLASS} = undef;
    $self->{VARIANTTYPE} = undef;
    $self->{REFALLELE} = undef;
    $self->{TUMORSEQALLELE1} = undef;
    $self->{TUMORSEQALLELE2} = undef;
    $self->{DBSNP} = undef;
    $self->{DBSNPVALIDSTATUS} = undef;
    $self->{TUMORBARCODE} = undef;
    $self->{MATCHEDNORMSAMPLEBARCODE} = undef;
    $self->{MATCHNORMSEQALLELE1} = undef;
    $self->{MATCHNORMSEQALLELE2} = undef;
    $self->{TUMORVALIDALLELE1} = undef;
    $self->{TUMORVALIDALLELE2} = undef;
    $self->{MATCH_NORM_VALID_ALLELE1} = undef;
    $self->{MATCH_NORM_VALID_ALLELE2} = undef;
    $self->{VERIFICATIONSTATUS} = undef;
    $self->{VALIDATIONSTATUS} = undef;
    $self->{MUTATIONSTATUS} = undef;
    $self->{SEQPHASE} = undef;
    $self->{SEQSOURCE} = undef;
    $self->{VALIDATIONMETHOD} = undef;
    $self->{SEQUENCER} = undef;
    $self->{TUMORSAMPLEUUID} = undef;
    $self->{MATCHNORMSAMPLEUUID} = undef;
    bless($self);
    return $self;
}

sub CHROME {
    my $self = shift;
    if (@_) { $self->{CHROME} = shift } 
    return $self->{CHROME};
}

sub POS {
    my $self = shift;
    if (@_) { $self->{POS} = shift }
    return $self->{POS};
}

sub ID {
    my $self = shift;
    if (@_) { $self->{ID} = shift }
    return $self->{ID};
}

sub REF {
    my $self = shift;
    if (@_) { $self->{REF} = shift }
    return $self->{REF};
}

sub ALT {
    my $self = shift;
    if (@_) { $self->{ALT} = shift }
    return $self->{ALT};
}

sub QUAL {
    my $self = shift;
    if (@_) { $self->{QUAL} = shift }
    return $self->{QUAL};
}

sub FILTER {
    my $self = shift;
    if (@_) { $self->{FILTER} = shift }
    return $self->{FILTER};
}

sub REF_COUNT_FRWD {
    my $self = shift;
    if (@_) { $self->{REF_COUNT_FRWD} = shift }
    return $self->{REF_COUNT_FRWD};
}

sub REF_COUNT_REV {
    my $self = shift;
    if (@_) { $self->{REF_COUNT_REV} = shift }
    return $self->{REF_COUNT_REV};
}

sub ALT_COUNT_FRWD {
    my $self = shift;
    if (@_) { $self->{ALT_COUNT_FRWD} = shift }
    return $self->{ALT_COUNT_FRWD};
}

sub ALT_COUNT_REV {
    my $self = shift;
    if (@_) { $self->{ALT_COUNT_REV} = shift }
    return $self->{ALT_COUNT_REV};
}

sub REF_COUNT_TUMOR_FRWD {
    my $self = shift;
    if (@_) { $self->{REF_COUNT_TUMOR_FRWD} = shift }
    return $self->{REF_COUNT_TUMOR_FRWD};
}

sub REF_COUNT_TUMOR_REV {
    my $self = shift;
    if (@_) { $self->{REF_COUNT_TUMOR_REV} = shift }
    return $self->{REF_COUNT_TUMOR_REV};
}

sub ALT_COUNT_TUMOR_FRWD {
    my $self = shift;
    if (@_) { $self->{ALT_COUNT_TUMOR_FRWD} = shift }
    return $self->{ALT_COUNT_TUMOR_FRWD};
}

sub ALT_COUNT_TUMOR_REV {
    my $self = shift;
    if (@_) { $self->{ALT_COUNT_TUMOR_REV} = shift }
    return $self->{ALT_COUNT_TUMOR_REV};
}

sub COV {
    my $self = shift;
    if (@_) { $self->{COV} = shift }
    return $self->{COV};
}

sub INDEL {
    my $self = shift;
    if (@_) { $self->{INDEL} = shift }
    return $self->{INDEL};
}








sub ENTREZ {
    my $self = shift;
    if (@_) { $self->{ENTREZ} = shift };
    return $self->{ENTREZ};
}

sub CENTER {
    my $self = shift;
    if (@_) { $self->{CENTER} = shift };
    return $self->{CENTER};
}

sub TCGAID {
    my $self = shift;
    if (@_) { $self->{TCGAID} = shift };
    return $self->{TCGAID};
}

sub STARTER {
    my $self = shift;
    if (@_) { $self->{STARTER} = shift };
    return $self->{STARTER};
}

sub ENDER {
    my $self = shift;
    if (@_) { $self->{ENDER} = shift };
    return $self->{ENDER};
}

sub STRAND {
    my $self = shift;
    if (@_) { $self->{STRAND} = shift };
    return $self->{STRAND};
}

sub VARIANTCLASS {
    my $self = shift;
    if (@_) { $self->{VARIANTCLASS} = shift };
    return $self->{VARIANTCLASS};
}

sub VARIANTTYPE {
    my $self = shift;
    if (@_) { $self->{VARIANTTYPE} = shift };
    return $self->{VARIANTTYPE};
}

sub REFALLELE {
    my $self = shift;
    if (@_) { $self->{REFALLELE} = shift };
    return $self->{REFALLELE};
}

sub TUMORSEQALLELE1 {
    my $self = shift;
    if (@_) { $self->{TUMORSEQALLELE1} = shift };
    return $self->{TUMORSEQALLELE1};
}

sub TUMORSEQALLELE2 {
    my $self = shift;
    if (@_) { $self->{TUMORSEQALLELE2} = shift };
    return $self->{TUMORSEQALLELE2};
}

sub DBSNP {
    my $self = shift;
    if (@_) { $self->{DBSNP} = shift };
    return $self->{DBSNP};
}

sub DBSNPVALIDSTATUS {
    my $self = shift;
    if (@_) { $self->{DBSNPVALIDSTATUS} = shift };
    return $self->{DBSNPVALIDSTATUS};
}

sub TUMORBARCODE {
    my $self = shift;
    if (@_) { $self->{TUMORBARCODE} = shift };
    return $self->{TUMORBARCODE};
}

sub MATCHEDNORMSAMPLEBARCODE {
    my $self = shift;
    if (@_) { $self->{MATCHEDNORMSAMPLEBARCODE} = shift };
    return $self->{MATCHEDNORMSAMPLEBARCODE};
}

sub MATCHNORMSEQALLELE1 {
    my $self = shift;
    if (@_) { $self->{MATCHNORMSEQALLELE1} = shift };
    return $self->{MATCHNORMSEQALLELE1};
}

sub MATCHNORMSEQALLELE2 {
    my $self = shift;
    if (@_) { $self->{MATCHNORMSEQALLELE2} = shift };
    return $self->{MATCHNORMSEQALLELE2};
}

sub TUMORVALIDALLELE1 {
    my $self = shift;
    if (@_) { $self->{TUMORVALIDALLELE1} = shift };
    return $self->{TUMORVALIDALLELE1};
}

sub TUMORVALIDALLELE2 {
    my $self = shift;
    if (@_) { $self->{TUMORVALIDALLELE2} = shift };
    return $self->{TUMORVALIDALLELE2};
}

sub MATCH_NORM_VALID_ALLELE1 {
    my $self = shift;
    if (@_) { $self->{MATCH_NORM_VALID_ALLELE1} = shift };
    return $self->{MATCH_NORM_VALID_ALLELE1};
}

sub MATCH_NORM_VALID_ALLELE2 {
    my $self = shift;
    if (@_) { $self->{MATCH_NORM_VALID_ALLELE2} = shift };
    return $self->{MATCH_NORM_VALID_ALLELE2};
}

sub VERIFICATIONSTATUS {
    my $self = shift;
    if (@_) { $self->{VERIFICATIONSTATUS} = shift };
    return $self->{VERIFICATIONSTATUS};
}

sub VALIDATIONSTATUS {
    my $self = shift;
    if (@_) { $self->{VALIDATIONSTATUS} = shift };
    return $self->{VALIDATIONSTATUS};
}

sub MUTATIONSTATUS {
    my $self = shift;
    if (@_) { $self->{MUTATIONSTATUS} = shift };
    return $self->{MUTATIONSTATUS};
}

sub SEQPHASE {
    my $self = shift;
    if (@_) { $self->{SEQPHASE} = shift };
    return $self->{SEQPHASE};
}

sub SEQSOURCE {
    my $self = shift;
    if (@_) { $self->{SEQSOURCE} = shift };
    return $self->{SEQSOURCE};
}

sub VALIDATIONMETHOD {
    my $self = shift;
    if (@_) { $self->{VALIDATIONMETHOD} = shift };
    return $self->{VALIDATIONMETHOD};
}

sub SEQUENCER {
    my $self = shift;
    if (@_) { $self->{SEQUENCER} = shift };
    return $self->{SEQUENCER};
}

sub TUMORSAMPLEUUID {
    my $self = shift;
    if (@_) { $self->{TUMORSAMPLEUUID} = shift };
    return $self->{TUMORSAMPLEUUID};
}

sub MATCHNORMSAMPLEUUID {
    my $self = shift;
    if (@_) { $self->{MATCHNORMSAMPLEUUID} = shift };
    return $self->{MATCHNORMSAMPLEUUID};
}

1;