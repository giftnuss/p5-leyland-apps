  package Teddy::Model;
# *********************
  our $VERSION = '0.01';
# **********************

use Moose;

with 'LeylandX::Database';

__PACKAGE__->meta->make_immutable;

no Moose;

1;

__END__

