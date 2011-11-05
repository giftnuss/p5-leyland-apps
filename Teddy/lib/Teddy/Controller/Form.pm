  package Teddy::Controller::Form;
# ********************************
  our $VERSION = '0.01';
# **********************

use Moose;
use Leyland::Parser;
use namespace::autoclean;

with 'Leyland::Controller';

prefix { '/teddy' }

post '^/photo' accepts 'multipart/form-data' {

    my $form = $c->form('photo');

    $c->forward('/give/photo');
}

1;

__END__

