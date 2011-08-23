use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name => 'LeylandX::Starter',
    license => 'perl',
    dist_abstract => 'Start a Leyland application from a Web',
    dist_author => 'Sebastian Knapp <rock@ccls-online.de>',
    dist_version => '0.00002',
    requires => {
        'perl' => '5.010001',
        'autodie' => '2.10',
        'Leyland' => 0.001001,
        'File::chdir' => '0.1004',
        'MooseX::Types::Path::Class' => '0.05',
        'Data::Structure::Util' => '0.13',
        'HTML::FormHandler' => '0.34001'
    },
    build_requires => {
        'Test::More' => 0,
        'Test::UseAllModules' => '0.12',
	'Test::File::Contents' => '0.20',
	'Data::Section' => '0.101621'
    },
    add_to_cleanup      => [ 'LeylandX-Starter-*' ],
    create_makefile_pl  => 'traditional',
    meta_add => {
        resources => {
            repository => 'git://github.com/giftnuss/p5-leyland-apps.git',
            homepage => 'http://github.com/giftnuss/p5-leyland-apps/tree/master/LeylandX-Starter'
        }
    }
);

$builder->create_build_script();
