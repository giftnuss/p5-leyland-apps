  package LeylandX::Starter::Build::Build
# ***************************************
; our $VERSION = '0.01';
# **********************
use Moose;
extends 'LeylandX::Starter::Task';
with 'LeylandX::Starter::Task::Files';

has '+file_map' =>
(
    default => sub {{
        'Build.PL' => 'Build.PL'
    }}
);

sub forProject
{
    my ($self,$project) = @_;
    my $opts = {
        app_name => $project->app_name,
        package_name => $project->package_name,
        author => $project->author,
        email => $project->email,
        abstract => $project->abstract
    };
    my $task = $self->new(opts => $opts);
    return $task;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__DATA__

_____[ Build.PL ]_______________________________________________________

use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name => '[== $package_name =]',
    license => 'perl',
    dist_abstract => '[== $abstract =]',
    dist_author => '[== $author =] <[== $email =]>',
    dist_version => '0.00001',
    requires => {
        'perl' => '5.010001',
        'Leyland' => '0.001004'
    },
    build_requires => {
        'Test::More' => 0,
        'Test::UseAllModules' => '0.12'
    },
    add_to_cleanup      => [ '[== $app_name =]-*' ],
    create_makefile_pl  => 'traditional',
    meta_add => {
        resources => {
            repository => 'git://github.com/giftnuss/p5-leyland-apps.git', # maybe?
            homepage => 'http://github.com/giftnuss/p5-leyland-apps/tree/master/[== $app_name =]'
        }
    }
);

$builder->create_build_script();
