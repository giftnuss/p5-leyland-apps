
use strict; use warnings; use utf8;

use Test::More tests => 1;

BEGIN {
    $ENV{PLACK_ENV} = 'testing';
    use_ok('Fluppe');
};


