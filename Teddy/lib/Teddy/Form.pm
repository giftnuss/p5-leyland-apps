package Teddy::Form;
# Abstract: Custom formular base class for your Leyland application

our $VERSION = "0.001";
$VERSION = eval $VERSION;

use Moose;
extends 'HTML::FormHandler';

has 'context' =>
(
    is => 'rw',
    isa => 'Leyland::Context'
);

sub to_json
{
    my ($self) = @_;
    return $self->context->json->to_json($self->value);
}

sub _self_id
    {
        my $class = blessed(shift);
        my $sep = shift || '::';
        my $pos = index($class,'Form::') + 6;
        $pos = $[ if $pos < $[;
        my $action = lc(substr($class,$pos));
        $action =~ s/::/$sep/g;
        return $action;
    }

has '+action' => (default => sub { shift->_self_id('/') });

has '+name' => (default => sub { shift->_self_id('_') });

# - customize me ;)
# has '+widget_wrapper' => (default => 'None');

sub localize_meth 
{
    my ($field,$msg,@args) = @_;
    # use it as it is
    # $msg =~ s/\[_(\d+)\]/%$1/g;
    
    return $field->form->context->loc($msg,@args);
}

__PACKAGE__->meta->make_immutable;
no Moose;

1;

__END__

=head1 NAME

Teddy::Form - Custom formular base class for your Leyland application

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 EXTENDS

L<HTML::FormHandler>

=head1 METHODS

=head1 AUTHOR

Sebastian Knapp, C<< <rock@ccls-online.de> >>

=head1 LICENSE AND COPYRIGHT

Copyright 2011 Sebastian Knapp.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


