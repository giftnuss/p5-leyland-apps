package LeylandX::Starter::Context;
use Moose;

extends 'Leyland::Context';

with 'LeylandX::Plugin::Frost',
     'LeylandX::Plugin::Form';

__PACKAGE__->meta->make_immutable();
no Moose;

1;

__END__

