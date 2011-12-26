#!/usr/bin/perl -w

use lib './lib';
use strict;
use warnings;
use Lab;
use Plack::Builder;

my $config = {
	app => 'Lab',
	views => ['Solution'],
	locales => './i18n'
};

my $a = Lab->new(config => $config);

my $app = sub {
	$a->handle(shift);
};

builder {
	# enable whatever Plack middlewares you wish here, a good example
	# would be the Session middleware.
	# --------------------------------------------------------------
	# the Static middleware will serve static files from the app's
	# public directory, remove it (or comment it) if your web server
	# is serving those files
	enable 'Static',
		path => qr{^/((images|js|css|fonts)/|favicon\.ico$|apple-touch-icon\.png$)},
		root => './public/';

	$app;
};
