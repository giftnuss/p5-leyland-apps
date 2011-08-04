use strict;
use warnings;
use Test::More tests => 3;

BEGIN {
    use_ok 'LeylandX::Starter::Project';
};

my %required = (
  root_dir => './t/root',
  package_name => 'Prj::Check'
);

my $opts = sub {{ %required, @_ }};


my $project = LeylandX::Starter::Project->new($opts->());

isa_ok($project,'LeylandX::Starter::Project');


sub start_project {
    my ($self,$c) = @_;
    my $args = {};

    $args->{package_name} = $c->form('project')->field('module')->value;
    $args->{root_dir} = $c->form('project')->field('directory')->value;
    $args->{abstract} = $c->form('project')->field('abstract')->value;

    $args->{author} = $c->form('author')->field('author')->value;
    $args->{email} = $c->form('author')->field('email')->value;

    my $features = $c->form('features');
    $args->{override_context} = {
        enabled => $features->field('with_context')->value,
        plugin_frost => $features->field('use_plugin_frost')->value,
        plugin_form => $features->field('use_plugin_form')->value
    };

    my $project = LeylandX::Starter::Project->new($args);
    my $builder = LeylandX::Starter::Build->new(project => $project);

    $builder->build();
}
ok(1);
