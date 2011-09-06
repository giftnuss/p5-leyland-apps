  package LeylandX::Starter::Build::Psgi
# **************************************
; our $VERSION = '0.01';
# **********************
use Moose;
extends 'LeylandX::Starter::Task';
with 'LeylandX::Starter::Task::Files';

has '+file_map' =>
(
    default => sub {{
        'app.psgi' => 'app.psgi'
    }}
);

sub forProject
{
    my ($self,$project) = @_;
    my $opts = {
        app_name => $project->app_name,
        package_name => $project->package_name
    };
    return $self->new(opts => $opts);
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__DATA__

____[ app.psgi ]____________________________________________________________
#!/usr/bin/perl -w

use lib './lib';
use strict;
use warnings;
use [== $package_name =];
use Plack::Builder;

my $config = {
	app => '[== $package_name =]',
	views => ['Tenjin'],
	locales => './i18n',
	logger => {
		class => 'LogHandler',
		opts => {
			outputs => [
				file => {
					filename => "[== lc($app_name) =].$ENV{PLACK_ENV}.log",
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
                testing => {
                     # keep console clean during unit tests
		     logger => {
                         class => 'LogHandler',
                         opts => {
			     outputs => [
			         screen => { log_to => "STDERR", minlevel => 0, maxlevel => 4}
                             ]
                         }
                     }
                }
	}
};

my $a = [== $package_name =]->new(config => $config);

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
