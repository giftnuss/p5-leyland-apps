
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name => 'Cosmos',
    license => 'perl',
    dist_abstract => 'Github Code Restaurant',
    dist_author => 'Sebastian Knapp <rock@ccls-online.de>',
    dist_version => '0.00001',
    requires => {
        'perl' => '5.010001',
        'Leyland' => '0.001004',
        'HTML::FormHandler' => '0.35002'
    },
    build_requires => {
        'Test::More' => 0,
        'Test::UseAllModules' => '0.12'
    },
    add_to_cleanup      => [ 'Cosmos-*' ],
    create_makefile_pl  => 'traditional',
    meta_add => {
        resources => {
            repository => 'git://github.com/giftnuss/p5-leyland-apps.git', # maybe?
            homepage => 'http://github.com/giftnuss/p5-leyland-apps/tree/master/Cosmos'
        }
    }
);

$builder->create_build_script();
