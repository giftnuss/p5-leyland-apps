  package LeylandX::Starter::Task::Builder
# ****************************************
; our $VERSION = '0.01';
# **********************
use Moose::Role;

use File::chdir;

requires qw( command );

has cwd =>
(
    is => 'ro',
    isa => 'Str',
    lazy => 1,
    default => sub {
        my ($self) = @_;
        return "" . $self->get_dependency('basedir')->basedir;
    }
);

sub build
{
    my ($self) = @_;
    local $CWD = $self->cwd;
    system($self->command);
}

no Moose::Role;

1;

__END__

