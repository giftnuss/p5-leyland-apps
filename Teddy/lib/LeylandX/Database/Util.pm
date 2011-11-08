  package LeylandX::Database::Util;
# *********************************
  our $VERSION = '0.01';
# **********************
use Moose::Role;
requires 'database';

use Class::Load;

has database_util =>
(
  is => 'rw'
);

sub setup_database
{
  my ($self,$cwe,$config) = @_;

  unless($self->database_util) {
      $self->database_util('LeylandX::Database::Util::SQLite');
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
