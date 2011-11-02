  package Teddy::View::TT2;
# *************************
  our $VERSION = '0.01';
# **********************

use Moose;

with 'LeylandX::View::TT2';

no Moose;

__PACKAGE__->meta->make_immutable;

1;

__END__

