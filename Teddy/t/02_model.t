
use strict;
use warnings;
use utf8;

use Test::More;

BEGIN {
  use_ok('Teddy::Model');
};

my $model = Teddy::Model->new();
isa_ok($model,'Teddy::Model','new needs no arguments');

unlink("./unittest.db") if -f "./unittest.db";
ok(! -f "./unittest.db",'old database removed');

eval {
  $model->setup_database('unittest',{});
};
ok(!$@,"simple database setup - $@");

my $name;
eval {
  my $dbh = $model->database->dbh();
  $name = $dbh->{'Name'};
};
ok(!$@,"can connect with database - $@");
is($name,'./unittest.db','database name');

my @tables = qw(
  category
  guest
  language
  photo
  photo_note
  session
  session_guest
  translation
);
is_deeply([$model->get_table_names],\@tables,'tables names');

done_testing();
