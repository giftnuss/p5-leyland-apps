  package LeylandX::Starter::Build::Basedir
# *****************************************
; our $VERSION = '0.01';
# **********************
use Moose;
with 'LeylandX::Starter::Task';

use MooseX::Types::Path::Class;

has basedir => (
    is => 'ro',
    isa => 'Path::Class::Dir'
);

sub detect
{
    my ($self) = @_;
    defined $self->basedir->stat;
}

sub build
{
    my ($self) = @_;
    return $self->basedir->mkpath;
}

sub depends { () }

sub forProject
{
    my ($self,$project) = @_;
    my $dir = Path::Class::Dir->new(
        $project->root_dir,
        $project->app_name
    );
    $self->new(basedir => $dir);
}

no Moose;
1;

__END__

=head2 Class Methods

=over 4

=item forProject


=back

