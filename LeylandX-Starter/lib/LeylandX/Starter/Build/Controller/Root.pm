  package LeylandX::Starter::Build::Controller::Root
# **************************************************
; our $VERSION = '0.01';
# **********************
use Moose;
extends 'LeylandX::Starter::Task';
with 'LeylandX::Starter::Task::Files';

has '+file_map' =>
(
    default => sub {{
        'Root.pm' => 'Root.pm'
    }}
);

sub forProject
{
    my ($self,$project) = @_;
    my $opts = {
        app_name => $project->app_name,
        package_name => $project->package_name,
        author => $project->author,
        email => $project->email
    };
    my $task = $self->new(opts => $opts);
    $task->file_map->{'Root.pm'} = 'lib/' . $project->package_path .
        '/Controller/Root.pm';
    return $task;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__


