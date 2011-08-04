  package LeylandX::Starter::Build::Manifest
# ******************************************
; our $VERSION = '0.01';
# **********************
use Moose;

with 'LeylandX::Starter::Task',
     'LeylandX::Starter::Task::Builder';

sub command { "$^X Build.PL && ./Build manifest" }

sub depends { qw
  ( 
    app
    basedir 
    build
    changes
    manifest_skip
    psgi
    root
    view_default
  ) 
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
        $build->set_dependency('context');
    }
    return $build;
}

no Moose;

1;

__END__

