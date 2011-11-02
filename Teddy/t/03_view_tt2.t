
use strict;
use warnings;
use Test::More;

use_ok('Teddy::View::TT2');

my $view = Teddy::View::TT2->new();

use Data::Dumper;
#print Dumper($view);

my $str;
$str = 'WER [% "Helo World!" | i18n %]';
is($view->render(\$str,{},0),'','');

done_testing;
