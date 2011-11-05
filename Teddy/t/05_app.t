
use strict;
use warnings;
use Leyland::Test;
use Test::More;

BEGIN {
  use_ok('Teddy');
};

app('Teddy');

my $views = app->views;
is(app->cwe,'staging','current working environment');
isa_ok($views->[0],'Teddy::View::TT2');
isa_ok(app->localizer,'LeylandX::Languages::Localizer');
is(app->context_class,'Teddy::Context','context class');

done_testing;
