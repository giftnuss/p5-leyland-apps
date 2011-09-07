  package Fluppe::Model;
# **********************
  our $VERSION = '0.01';
# **********************

use Class::Load ();

use Moose;

sub setup {
  my ($self,$cwe,$config) = @_;
  $self->_setup_database($cwe,$config);
}

has database =>
(
  is => 'ro',
  isa => 'DBIx::Connector'
);

sub _setup_database
{
  my ($self,$cwe,$config) = @_;

  my $connector = 'Fluppe::Connector::SQLite';
  Class::Load::load_class($connector);
  $self->{'database'} = $connector->setup($cwe,$config);
}

no Moose;

__PACKAGE__->meta->make_immutable;

__END__
