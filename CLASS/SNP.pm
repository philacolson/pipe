#!/usr/bin/perl

package CLASS::SNP;
 
use strict;
use warnings;

sub new {
    my $self = {};
    $self->{CHROME} = undef;
    $self->{POS}    = undef;
    $self->{ID}     = undef;
    $self->{REF}    = undef;
    $self->{ALT}    = undef;
    $self->{QUAL}   = undef;
    $self->{FILTER} = undef;
    bless($self);
    return $self;
}

sub CHROME {
    my $self = shift;
    if (@_) { $self->{CHROME} = shift }
    # print "$self->{CHROME}\n";
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

1;