  package LeylandX::Starter::Form::Author;
# ****************************************
  our $VERSION = '0.01';
# **********************
use HTML::FormHandler::Moose;
extends 'LeylandX::Starter::Form';

has_field author =>
(
    type => 'Text',
    default => 'Some Guy'
);

has_field email =>
(
    type => 'Email',
    default => 'some_guy@email.com'
);

has_field 'submit' =>
(
    type => 'Submit',
    value => 'Update'
);

no HTML::FormHandler::Moose;
1;

__END__

