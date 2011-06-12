  package LeylandX::Starter::Build::App
# *************************************
; our $VERSION = '0.01';
# **********************
use Moose;
with 'LeylandX::Starter::Task::Files';

has '+file_map' =>
(
    default => sub {{
        'App.pm' => 'App.pm'
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
    $task->file_map->{'App.pm'} = 'lib/' . $project->package_path . '.pm';
    return $task;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__


