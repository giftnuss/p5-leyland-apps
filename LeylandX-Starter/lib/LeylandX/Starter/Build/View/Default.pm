  package LeylandX::Starter::Build::View::Default
# ***********************************************
; our $VERSION = '0.01';
# **********************
use Moose;
extends 'LeylandX::Starter::Task';
with 'LeylandX::Starter::Task::Files';

has '+name' => (default => 'view_default');

has '+file_map' =>
(
    default => sub {{
        'main.html' => 'views/layouts/main.html',
        'index.html' => 'views/index.html'
    }}
);

sub forProject
{
    my ($self,$project) = @_;
    my $opts = {
        app_name => $project->app_name
    };
    return $self->new(opts => $opts);
}

__PACKAGE__->meta->make_immutable;
no Moose;

1;

__END__

