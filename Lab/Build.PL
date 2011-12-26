
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name => 'Lab',
    license => 'perl',
    dist_abstract => 'Ein Editor',
    dist_author => 'Sebastian B. Knapp <rock@ccls-online.de>',
    dist_version => '0.00001',
    requires => {
        'perl' => '5.010001',
        'Leyland' => '0.001007',
        'Solution' => '0.0004'},
    build_requires => {
        'Test::More' => 0,
        'Test::UseAllModules' => '0.12'
    },
    add_to_cleanup      => [ 'Lab-*' ],
    create_makefile_pl  => 'traditional',
    meta_add => {
        resources => {
            repository => 'git://github.com/giftnuss/p5-leyland-apps.git', # maybe?
            homepage => 'http://github.com/giftnuss/p5-leyland-apps/tree/master/Lab'
        }
    }
);

$builder->create_build_script();
