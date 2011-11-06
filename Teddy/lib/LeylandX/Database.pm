  package LeylandX::Database;
# ***************************
  our $VERSION = '0.0001';
# ************************
use Moose::Role;

has database =>
(
  is => 'ro',
  isa => 'DBIx::Connector'
);

no Moose::Role;

1;

__END__

