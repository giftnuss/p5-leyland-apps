  package LeylandX::Starter::Task::Component::FileMap
# ***************************************************
; our $VERSION = '0.01';
# **********************
use Moose::Role;

after 'BUILD' => sub
{
    my ($self) = @_;
    $self->add_dependency('basedir');
    $self->add_dependency('dirtree');
};

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

no Moose::Role;

1;

__END__
