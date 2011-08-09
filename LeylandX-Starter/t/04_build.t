use strict;
use warnings;

use 5.010;
use Test::More;

use Data::Dumper;
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
    'i18n',
    't'];

is_deeply($dirtree->dir_list,$expect_dirlist,'default dirtree');

my $tasks = $build->tasks;

my @tasknames = sort keys %$tasks;

my $expected_tasknames = [
    'app',
    'basedir',
    'build',
    'changes',
    'dirtree',
    'gitignore',
    'manifest',
    'manifest_skip',
    'psgi',
    'root',
    'view_default'];

is_deeply(\@tasknames,$expected_tasknames,'tasknames');
$build->build();

# -----------------------------------------------------
$project = LeylandX::Starter::Project->new(
    'author' => 'Just another perl hacker.',
    'email' => 'japh@example.com',
    'package_name' => 'Lx::Context',
    'root_dir' => $rootdir,
    'override_context' => {
        enabled => 1,
        plugin_frost => 1,
        plugin_form => 1
    }
);
$build = LeylandX::Starter::Build->new(project => $project);
isa_ok($build,'LeylandX::Starter::Build');

my $context = LeylandX::Starter::Build::Context->forProject($project);
is_deeply([$context->depends],
    ['basedir','dirtree','plugin_frost','plugin_form'],'Context Depends');
is_deeply([$context->plugins],
    ['LeylandX::Starter::Build::Plugin::Frost',
     'LeylandX::Starter::Build::Plugin::Form'],'Context Plugins');

$tasks = $build->tasks;

@tasknames = sort keys %$tasks;

$expected_tasknames = [
    'app',
    'basedir',
    'build',
    'changes',
    'context',
    'dirtree',
    'gitignore',
    'manifest',
    'manifest_skip',
    'plugin_form',
    'plugin_frost',
    'psgi',
    'root',
    'view_default'];

is_deeply(\@tasknames,$expected_tasknames,'tasknames');
$build->build();

done_testing();
