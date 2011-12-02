  package Teddy::Model;
# *********************
  our $VERSION = '0.01';
# **********************
use Teddy::Define ();
use Class::Load ();

use Moose;

with 'LeylandX::Database';
with 'LeylandX::Database::Util';

after 'setup_database' => sub {
    my ($self) = @_;

    unless($self->get_table_names) {
        $self->load_schema;
    }
};

sub load_schema {
  my ($self) = @_;
  my $dbh = $self->database->dbh();
  foreach my $sql (Teddy::Define->sql_for('SQLite')) {
      $dbh->do($sql);
  }
}

{
    my %model;
    sub model {
        my ($self,$name) = @_;
        return $model{$name} ||= do {
             my $class = 'Teddy::Model::' . ucfirst($name);
             Class::Load::load_class($class);
             $class->new(database => $self->database);
        };
    }
};

no Moose;

__PACKAGE__->meta->make_immutable;

1;

__END__

