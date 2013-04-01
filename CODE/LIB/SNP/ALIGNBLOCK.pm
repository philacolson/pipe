#!/usr/bin/perl

package LIB::SNP::ALIGNBLOCK;
 
use strict;
use warnings;

sub new {
    my $self = {};
    $self->{ID} = undef;
    $self->#REFER TO OBJECT
    bless($self);
    return $self;
}


sub ID {
    my $self = shift;
    #if (@_) is the same as the scalar command.  If the array has anything in it, it is true.
    if (@_) { $self->{ID} = shift }
    return $self->{ID};
}

sub GENELIST {
    my $self = shift;
    my $newGene = new GENELIST
    if (@_) { }
}

1;