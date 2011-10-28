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

sub setup_database
{
  my ($self,$cwe,$config) = @_;

  my $connector = 'LeylandX::Database::SQLite';
  Class::Load::load_class($connector);
  $self->{'database'} = $connector->setup($cwe,$config);
}

no Moose::Role;

1;

__END__

