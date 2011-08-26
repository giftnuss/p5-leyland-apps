#!/usr/bin/perl -w

use lib './lib';
use strict;
use warnings;
use Fluppe;
use Plack::Builder;

my $config = {
	app => 'Fluppe',
	views => ['Tenjin'],
	locales => './i18n',
        workspace => './workspace',
	logger => {
		class => 'LogHandler',
		opts => {
			outputs => [
				file => {
					filename => "fluppe.$ENV{PLACK_ENV}.log",
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

my $a = Fluppe->new(config => $config);

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
