
use strict;
use warnings;
use utf8;

use Test::More tests => 3;

BEGIN {
  use_ok('Teddy::Define');
  use_ok('Teddy::Model');
};

my $schema = DBIx::Define->get_schema('teddy');

my @tables = map { $_->name } $schema->get_tables;

my @planned = ('project','repository','project_repository');

is_deeply(\@tables,\@planned,'table names');


print join "|", Fluppe::Define->sql_for('SQLite');
#use Data::Dumper;

#print Dumper $schema;
