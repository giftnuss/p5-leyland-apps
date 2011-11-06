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
    my @params = ( photo => $c->uploads->{'photo'} );

    use Data::Dumper;
    warn Dumper(\@params);

    $form->process( params => { @params } );
    #return unless ( $form->validated );



    $c->forward('/give/photo');
}

1;

__END__

