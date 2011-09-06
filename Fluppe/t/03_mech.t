
use strict; use warnings; use utf8;

use Plack::Test;
use Plack::Util;

use Test::More;
use Test::Requires 'Test::WWW::Mechanize::PSGI';

BEGIN {
    $ENV{PLACK_ENV} = 'testing';
};

my $app = Plack::Util::load_psgi 'app.psgi';

my $mech = Test::WWW::Mechanize::PSGI->new(app => $app);
$mech->get_ok('/');

is( $mech->ct, 'text/html', 'Is text/html' );
$mech->content_contains('running on Leyland v0.001007');

done_testing;

