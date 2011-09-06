
use strict; use warnings; use utf8;

use Test::More tests => 1;

BEGIN {
  use_ok('Fluppe::Define');
};

my $schema = DBIx::Define->get_schema('fluppe');

use Data::Dumper;

print Dumper $schema;
