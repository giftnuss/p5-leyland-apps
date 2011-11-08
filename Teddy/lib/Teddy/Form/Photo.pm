  package Teddy::Form::Photo;
# ***************************
  our $VESION = '0.01';
# *********************
use HTML::FormHandler::Moose;
extends 'Teddy::Form';

use Teddy::Form::Field::Photo;

has '+enctype' => ( default => 'multipart/form-data');

has_field photo =>
(
    type => '+Teddy::Form::Field::Photo',
    label => 'Photo',
    max_size => 8_000_000,
    required => 1
);

# TODO: check photo does not already exists
sub validate_photo
{

}


no HTML::FormHandler::Moose;

1;

__END__

