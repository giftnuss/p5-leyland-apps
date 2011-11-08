
use strict;
use warnings;
use Test::More;

BEGIN {
  use_ok('Teddy::Photo');
};

my $photo;
eval {
  $photo = Teddy::Photo->new();
};
ok(!$@,"new without args works - $@");

$photo->create(1,"./t/data/ghost.png");

done_testing();

