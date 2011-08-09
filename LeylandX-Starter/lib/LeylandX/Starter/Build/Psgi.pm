  package LeylandX::Starter::Build::Psgi
# **************************************
; our $VERSION = '0.01';
# **********************
use Moose;
extends 'LeylandX::Starter::Task';
with 'LeylandX::Starter::Task::Files';

has '+file_map' =>
(
    default => sub {{
        'app.psgi' => 'app.psgi'
    }}
);

sub forProject
{
    my ($self,$project) = @_;
    my $opts = {
        app_name => $project->app_name,
        package_name => $project->package_name
    };
    return $self->new(opts => $opts);
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__


