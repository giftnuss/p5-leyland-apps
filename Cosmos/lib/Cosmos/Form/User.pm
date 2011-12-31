  package Cosmos::Form::User;
# **************************
use HTML::FormHandler::Moose;

extends 'Cosmos::Form';

has '+auto_fieldset' => (default => undef);

has_field user =>
(
    type => 'Text',
    label => 'Github Username',
    required => 1
);

no HTML::FormHandler::Moose;

1;

__END__


