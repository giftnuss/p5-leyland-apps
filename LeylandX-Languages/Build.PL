
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name => 'LeylandX::Languages',
    license => 'perl',
    dist_abstract => 'Play with Leyland i18n',
    dist_author => 'Sebastian Knapp <rock@ccls-online.de>',
    dist_version => '0.000011',
    requires => {
        'perl' => '5.010001',
        'Leyland' => '0.001004'
    },
    build_requires => {
        'Test::More' => 0,
        'Test::UseAllModules' => '0.12'
    },
    add_to_cleanup      => [ 'LeylandX-Languages-*' ],
    create_makefile_pl  => 'traditional',
    meta_add => {
        resources => {
            repository => 'git://github.com/giftnuss/p5-leyland-apps.git', # maybe?
            homepage => 'http://github.com/giftnuss/p5-leyland-apps/tree/master/LeylandX-Languages'
        }
    }
);

$builder->create_build_script();
