  package LeylandX::Starter::Build
# ********************************
; our $VERSION = '0.02';
# **********************
use Moose;
use Module::Pluggable::Object;

use LeylandX::Starter::Project;

require Leyland::Cmd::Command::app;

has search_path =>
(
   is => 'rw',
   isa => 'ArrayRef',
   default => sub { [ __PACKAGE__ ] },
   documentation => q{Task root namespaces.}
);

has tasks =>
(
   is => 'rw',
   isa => 'HashRef',
   builder => 'load_default_tasks',
   lazy => 1
);

has project =>
(
   is => 'ro',
   does => 'LeylandX::Starter::Project',
   required => 1
);

has tenjin =>
(
   is => 'ro',
   isa => 'Tenjin',
   lazy => 1,
   default => sub { Tenjin->new({ cache => 0 }); }
);

sub build
{
    my ($self,$target) = (@_,'ALL');
    $self->load_default_templates;

    my %done;
    my %tasks = %{$self->tasks};
    my @build = $target eq 'ALL' ? keys(%tasks) : ($target);

    while(@build) {
        $target = shift @build;
        next if $done{$target};
        foreach my $dep ($tasks{$target}->depends) {
            $self->build($dep) unless $done{$dep};
        }
        $tasks{$target}->set_dependency($_,$tasks{$_})
            foreach $tasks{$target}->depends;

        unless( $tasks{$target}->detect ) {
            $tasks{$target}->set_tenjin($self->tenjin)
                if $tasks{$target}->can('set_tenjin');
            $self->load_templates(blessed $tasks{$target});

            $tasks{$target}->build
        }
        $done{$target}++;
    }
}

sub load_default_tasks
{
    my ($self) = @_;
    my $tasks = {};
    my $loader = Module::Pluggable::Object->new(
        search_path => $self->search_path,
        require => 1,
        inner => 0,
        except => qr/^.*::Build::(Plugin)::.*$/
    );
    $self->_setup_tasks($loader,$tasks);
    return $tasks;
}

sub _setup_tasks {
    my ($self,$loader,$tasks) = @_;

    for my $plugin ($loader->plugins) {
        if(my $task = $plugin->forProject($self->project) ) {
            if( defined $tasks->{$task->name} ) {
                warn "taskname $task->name already in use.";
                next;
            }
            $tasks->{$task->name} = $task;
            $self->_setup_tasks($task,$tasks);       
        }
    }
}

my %data;
sub load_templates
{
    my ($self,$pkg) = @_;
    local $_;

    unless(exists $data{$pkg}) {
        my %tmpl;
        my $data = "${pkg}::DATA";

        if( defined *{$data} ) {
            %tmpl = do { local $/; "", split /_____\[ (\S+) \]_+\n/, <$data> };
            for (values %tmpl) {
                s/^!=([a-z])/=$1/gxms;
            }
        }
        $data{$pkg} = \%tmpl;
    }
    for (keys %{$data{$pkg}}) {
        $self->register_template($_,$data{$pkg}->{$_});
    }
}

sub load_default_templates
{
    my ($self) = @_;
    $self->load_templates('Leyland::Cmd::Command::app');
}

sub register_template
{
    my ($self,$name,$data) = @_;
    my $tmpl = Tenjin::Template->new;
    $tmpl->convert($data);
    $tmpl->compile;
    $self->tenjin->register_template($name,$tmpl);
}

__PACKAGE__->meta->make_immutable();

no Moose;

1;

__END__

=head1 NAME

LeylandX::Starter::Build - build a leyland application

=head1 DESCRIPTION

=head2 Attributes

=over 4

=item search_path

Array reference with package names where Module::Pluggable::Object
is looking for task classes.


