  package Teddy::Model;
# *********************
  our $VERSION = '0.01';
# **********************

use Teddy::Define ();

use Moose;

with 'LeylandX::Database',
     'LeylandX::Database::Util';

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


__PACKAGE__->meta->make_immutable;

no Moose;

1;

__END__

