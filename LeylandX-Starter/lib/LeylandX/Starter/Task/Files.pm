  package LeylandX::Starter::Task::Files
# **************************************
; our $VERSION = '0.01';
# **********************
use Moose::Role;

with 'LeylandX::Starter::Task::Template',
     'LeylandX::Starter::Task';

has file_map =>
(
    is => 'rw',
    isa => 'HashRef',
    lazy => 1,
    default => sub { {} }
);

sub detect
{
    my ($self) = @_;
    my $basedir = $self->get_dependency('basedir')->basedir;

    foreach my $file (values %{$self->file_map}) {
        Path::Class::File->new($basedir,$file)->stat or return 0;
    }
    return 1;
}

sub build
{
    my ($self) = @_;
    my $basedir = $self->get_dependency('basedir')->basedir;

    foreach my $tmpl (keys %{$self->file_map}) {
        my $file = Path::Class::File->new($basedir,$self->file_map->{$tmpl});
        next if $file->stat;

        $self->render_file($file,$tmpl);
    }
}

sub depends { qw( basedir dirtree ) }

no Moose::Role;
1;

__END__

