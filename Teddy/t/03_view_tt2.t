
use strict;
use warnings;
use Test::More;

use_ok('Teddy::View::TT2');
use_ok('LeylandX::Languages::Localizer');

my $view = Teddy::View::TT2->new();
my $loc = LeylandX::Languages::Localizer->new(path => './i18n');

$view->set_localizer($loc);
ok(defined($view->engine->{SERVICE}->{CONTEXT}->{LOCALIZER}),
  "localizer stored in template context");

use Data::Dumper;
#print Dumper($view);

my $str;
$str = '[% "My name is %1." | i18n("Teddy") %]';

is($view->render(\$str,{},0),'My name is Teddy.','no lang');
is($view->render(\$str,{c => {lang => 'en'}},0),'My name is Teddy.','lang => en');
is($view->render(\$str,{c => {lang => 'de'}},0),'Mein Name ist Teddy.','lang => de');
is($view->render(\$str,{c => {lang => 'fi'}},0),'Nimeni on Teddy.','lang => fi');


done_testing;
