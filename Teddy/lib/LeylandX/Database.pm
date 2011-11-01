  package LeylandX::Database;
# ***************************
  our $VERSION = '0.0001';
# ************************

use Class::Load;
use Moose::Role;

has database_util =>
(
  is => 'rw'
);

has database =>
(
  is => 'ro',
  isa => 'DBIx::Connector'
);

sub setup_database
{
  my ($self,$cwe,$config) = @_;

  unless($self->database_util) {
      $self->database_util('LeylandX::Database::SQLite');
  }
  Class::Load::load_class($self->database_util);
  $self->{'database'} = $self->database_util->setup($cwe,$config);
}

sub get_table_names
{
    my ($self) = @_;
    return $self->database_util->tables($self->database);
}

no Moose::Role;

1;

__END__

