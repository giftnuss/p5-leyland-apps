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

    $form->process( params => { @params } );

    if( $form->validated ) {
         warn Dumper($form->field('photo')->value);

            # perform validated form actions
    }
    else {
        $c->forward('/give/away');
    }
    $c->forward('/give/photo');
}

1;

__END__

