  package LeylandX::Starter::Build::Changes
# *****************************************
; our $VERSION = '0.01';
# **********************
use Moose;
with 'LeylandX::Starter::Task::Files';

has '+file_map' =>
(
    default => sub {{
        Changes => 'Changes'
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


