use strict;
use warnings;

use 5.010;
use Test::More;

use File::Basename qw(dirname);
use File::Path qw(mkpath remove_tree);

BEGIN {
    use_ok('LeylandX::Starter::Build');
    use_ok('LeylandX::Starter::Build::Basedir');
    use_ok('LeylandX::Starter::Build::Dirtree');
};

my $rootdir = dirname(__FILE__) . '/root';
mkpath($rootdir) unless -d $rootdir;

remove_tree($rootdir,{keep_root => 1});

my $project = LeylandX::Starter::Project->new(
    'author' => 'Just another perl hacker.',
    'email' => 'japh@example.com',
    'package_name' => 'Lx::Test',
    'root_dir' => $rootdir
);
my $build = LeylandX::Starter::Build->new(project => $project);
isa_ok($build,'LeylandX::Starter::Build');

my $basedir = LeylandX::Starter::Build::Basedir->new();
is($basedir->name,'basedir','task name is basedir');

my $dirtree = LeylandX::Starter::Build::Dirtree->new(
    package_path => 'Lx/Test');

is($dirtree->name,'dirtree','task name is dirtree');

my $expect_dirlist = [
    'lib/Lx/Test/Controller',
    'views/layouts',
    'public/css',
    'public/images',
    'public/js',
    'i18n'];

is_deeply($dirtree->dir_list,$expect_dirlist,'default dirtree');

my $tasks = $build->tasks;

my @tasknames = sort keys %$tasks;

my $expected_tasknames = [
    'app',
    'basedir',
    'changes',
    'dirtree',
    'manifest_skip',
    'psgi',
    'root',
    'view_default'];

is_deeply(\@tasknames,$expected_tasknames,'tasknames');
$build->build();

done_testing();
