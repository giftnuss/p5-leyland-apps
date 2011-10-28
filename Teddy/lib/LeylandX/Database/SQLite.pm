  package LeylandX::Database::SQLite;
# **********************************
use strict; use warnings; use utf8;

use Try::Tiny;
use DBIx::Connector;
#use Fluppe::Define;

sub setup {
  my ($class,$cwe,$config) = @_;

  my $dsn = "dbi:SQLite:./" . $cwe . '.db';
  my ($username,$password) = ('','');

  my $db = DBIx::Connector->new($dsn, $username, $password, {
        RaiseError => 1,
        AutoCommit => 1,
  });

 # $class->load_schema($db);
  return $db;
}

sub tables { 
    my ($self,$db) = @_;
    my $sth  = $db->dbh->prepare(<<__SQL__);
SELECT name FROM sqlite_master
WHERE type IN ('table','view') AND name NOT LIKE 'sqlite_%'
ORDER BY 1
__SQL__
    $sth->execute;
    my @tables;
    while ( my $row = $sth->fetchrow_hashref ) {
        push @tables, $row->{name};
    }
    return @tables;
}

sub load_schema {
  my ($self,$db) = @_;

  unless($self->tables($db)) {
    foreach my $sql (Fluppe::Define->sql_for('SQLite')) {
      $db->dbh->do($sql);
    }
  }
}

1;

__END__

