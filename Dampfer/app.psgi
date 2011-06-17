#!/usr/bin/perl -w

use lib './lib';
use strict;
use warnings;
use Dampfer;
use Plack::Builder;

my $config = {
	app => 'Dampfer',
	views => ['Tenjin'],
	locales => './i18n',
	logger => {
		class => 'LogHandler',
		opts => {
			outputs => [
				file => {
					filename => "dampfer.$ENV{PLACK_ENV}.log",
					minlevel => 0,
					maxlevel => 8,
					utf8 => 1,
				},
				screen => {
					log_to   => "STDERR",
					minlevel => 0,
					maxlevel => 8,
				},
			]
		}
	},
	environments => {
		development => {
			# options in here will override top level options when running in the development environment
		},
		deployment => {
			# options in here will override top level options when running in the deployment environment
		},
	}
};

my $a = Dampfer->new(config => $config);

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
