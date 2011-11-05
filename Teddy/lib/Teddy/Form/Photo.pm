  package Teddy::Form::Photo;
# ***************************
  our $VESION = '0.01';
# *********************
use HTML::FormHandler::Moose;
extends 'Teddy::Form';

has '+enctype' => ( default => 'multipart/form-data');

has_field photo =>
(
    type => 'Upload',
    label => 'Photo',
    max_size => 8_000_000
);

1;

__END__

