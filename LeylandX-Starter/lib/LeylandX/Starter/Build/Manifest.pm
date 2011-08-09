  package LeylandX::Starter::Build::Manifest
# ******************************************
; our $VERSION = '0.01';
# **********************
use Moose;

extends 'LeylandX::Starter::Task';
with 'LeylandX::Starter::Task::Builder';

sub command { "$^X Build.PL && ./Build manifest" }

sub BUILD
{ 
    my ($self) = @_;
    foreach my $dep (qw( 
    app
    basedir 
    build
    changes
    manifest_skip
    psgi
    root
    view_default
    )) {
    $self->add_dependency($dep);
    }
}

sub detect 
{
    my ($self) = @_;
    my $basedir = $self->get_dependency('basedir')->basedir;
    my $file = Path::Class::File->new($basedir,'MANIFEST');

    return !! $file->stat;
}

sub forProject
{
    my ($self,$project) = @_;
    my $build = $self->new();
    if($project->override_context->{enabled}) {
        $build->add_dependency('context');
    }
    return $build;
}

no Moose;

1;

__END__

