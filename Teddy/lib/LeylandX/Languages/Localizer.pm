  package LeylandX::Languages::Localizer;
# ***************************************
  our $VERSION = '0.01';
# **********************

use Moose;

extends 'Leyland::Localizer';

sub get_langcodes_for_msg
{
    my ($self,$msg) = @_;

    return unless exists $self->w->{locales}->{$msg};
    return sort keys %{ $self->w->{locales}->{$msg} }; 
}

no Moose;
1;
