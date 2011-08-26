
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name => 'Fluppe',
    license => 'perl',
    dist_abstract => 'Smoking could be healthy',
    dist_author => 'Sebastian Knapp <rock@ccls-online.de>',
    dist_version => '0.00001',
    requires => {
        'perl' => '5.010001',
        'Leyland' => '0.001004',
        'HTML::FormHandler' => '0.35002',
        'Config::INI' => '0.018',
        'TAP::Formatter::HTML' => '0.09'
    },
    build_requires => {
        'Test::More' => 0,
        'Test::UseAllModules' => '0.12'
    },
    add_to_cleanup      => [ 'Fluppe-*' ],
    create_makefile_pl  => 'traditional',
    meta_add => {
        resources => {
            repository => 'git://github.com/giftnuss/p5-leyland-apps.git', # maybe?
            homepage => 'http://github.com/giftnuss/p5-leyland-apps/tree/master/Fluppe'
        }
    }
);

$builder->create_build_script();