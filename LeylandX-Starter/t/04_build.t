use strict;
use warnings;

use 5.010;
use Test::More;
use Test::File::Contents;

use Data::Dumper;
use Data::Section -setup;
use File::Basename qw(dirname);
use File::Path qw(mkpath remove_tree);
use File::Spec;

BEGIN {
    use_ok('LeylandX::Starter::Build');
    use_ok('LeylandX::Starter::Build::Basedir');
    use_ok('LeylandX::Starter::Build::Dirtree');
};

sub check_file {
    my ($build,$file,$section) = @_;
    $file = [$file] unless ref $file;
    my $filename = File::Spec->catfile(
	$build->get_task('basedir')->basedir,@$file);
    my $test = __PACKAGE__->section_data($section);
    file_contents_eq($filename, $$test);
}

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

check_file($build,'MANIFEST','manifest1');

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

check_file($build,'MANIFEST','manifest2');

# -----------------------------------------------------
$project = LeylandX::Starter::Project->new(
    'author' => 'Just another perl hacker.',
    'email' => 'japh@example.com',
    'package_name' => 'Lx::Form',
    'root_dir' => $rootdir
);
$project->form_helper->{enabled} = 1;
$project->form_helper->{custom_base} = 1;

$build = LeylandX::Starter::Build->new(project => $project);
isa_ok($build,'LeylandX::Starter::Build');

$tasks = $build->tasks;

@tasknames = sort keys %$tasks;

$expected_tasknames = [
    'app',
    'basedir',
    'build',
    'changes',
    'dirtree',
    'form',
    'gitignore',
    'manifest',
    'manifest_skip',
    'psgi',
    'root',
    'view_default'];

is_deeply(\@tasknames,$expected_tasknames,'tasknames');
$build->build();

check_file($build,'MANIFEST','manifest3');
check_file($build,'Build.PL','build.pl.3');

done_testing();

__DATA__

__[ manifest1 ]________________________________________________________________
app.psgi
Build.PL
Changes
lib/Lx/Test.pm
lib/Lx/Test/Controller/Root.pm
MANIFEST			This list of files
MANIFEST.SKIP
views/index.html
views/layouts/main.html
__[ manifest2 ]________________________________________________________________
app.psgi
Build.PL
Changes
lib/LeylandX/Plugin/Form.pm
lib/LeylandX/Plugin/Frost.pm
lib/Lx/Context.pm
lib/Lx/Context/Context.pm
lib/Lx/Context/Controller/Root.pm
MANIFEST			This list of files
MANIFEST.SKIP
views/index.html
views/layouts/main.html
__[ manifest3 ]________________________________________________________________
app.psgi
Build.PL
Changes
lib/Lx/Form.pm
lib/Lx/Form/Controller/Root.pm
lib/Lx/Form/Form.pm
MANIFEST			This list of files
MANIFEST.SKIP
views/index.html
views/layouts/main.html
__[ build.pl.3 ]________________________________________________________________

use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name => 'Lx::Form',
    license => 'perl',
    dist_abstract => 'TODO - what is this for?',
    dist_author => 'Just another perl hacker. <japh@example.com>',
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
    add_to_cleanup      => [ 'Lx-Form-*' ],
    create_makefile_pl  => 'traditional',
    meta_add => {
        resources => {
            repository => 'git://github.com/giftnuss/p5-leyland-apps.git', # maybe?
            homepage => 'http://github.com/giftnuss/p5-leyland-apps/tree/master/Lx-Form'
        }
    }
);

$builder->create_build_script();
