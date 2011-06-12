use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name => 'LeylandX::Starter',
    license => 'perl',
    dist_abstract => 'Start a Leyland application from a Web',
    dist_author => 'Sebastian Knapp <rock@ccls-online.de>',
    dist_version => '0.00001',
    requires => {
        'perl' => '5.010001',
        'autodie' => '2.10',
        'Leyland' => 0.001001,
        'MooseX::Types::Path::Class' => '0.05',
        'Data::Structure::Util' => '0.13'
    },
    build_requires => {
        'Test::More' => 0,
        'Test::UseAllModules' => '0.12'
    },
    add_to_cleanup      => [ 'LeylandX-Starter-*' ],
    create_makefile_pl  => 'traditional',
    meta_add => {
        resources => {
            repository => 'git://github.com/giftnuss/p5-leylandx-starter.git',
            homepage => 'http://github.com/giftnuss/p5-leylandx-starter/tree/master'
        }
    }
);

$builder->create_build_script();
