#!/usr/bin/perl -w

use lib './lib';
use strict;
use warnings;
use LeylandX::Starter;
use Plack::Builder;

my $config = {
	app => 'LeylandX::Starter',
	views => ['Tenjin'],
	locales => './i18n',
	environments => {
		development => {
			# options in here will override top level options when running in the development environment
		},
		deployment => {
			# options in here will override top level options when running in the deployment environment
		},
	}
};

my $a = LeylandX::Starter->new(config => $config);

my $app = sub {
	$a->handle(shift);
};

builder {
        enable 'Debug';

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
