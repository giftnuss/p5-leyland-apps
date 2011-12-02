
use strict;
use warnings;

use Leyland::Test;
use Test::More;

BEGIN {
  use_ok('Teddy::Model');
};

app('Teddy');

my $photo = app->model->model('photo');

print Dumper($photo);

use Data::Dumper;


done_testing();
