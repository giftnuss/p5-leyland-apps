use strict;
use warnings;
use Test::More tests => 1;

use 5.010;

use LeylandX::Starter::Form::Author;

my $form = LeylandX::Starter::Form::Author->new;

isa_ok($form,'LeylandX::Starter::Form::Author');

say $form->render;
