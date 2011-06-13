  package LeylandX::Starter::Build::Dirtree
# *****************************************
; our $VERSION = '0.01';
# **********************
use Moose;
with 'LeylandX::Starter::Task';

use MooseX::Types::Path::Class;

has package_path => (
   is => 'ro',
   isa => 'Str',
   required => 1
);

has dir_list => (
   is => 'rw',
   isa => 'ArrayRef[Str]',
   lazy => 1,
   default => sub {
      my $self = shift;
      [ 'lib/' . $self->package_path . '/Controller'
      , 'views/layouts'
      , 'public/css'
      , 'public/images'
      , 'public/js'
      , 'i18n'
      , 't'
      ]
   }
);

sub depends { qw/basedir/ }

sub detect
{
    my ($self) = @_;
    my $basedir = $self->get_dependency('basedir')->basedir;

    foreach my $dir (@{$self->dir_list}) {
        Path::Class::Dir->new($basedir,$dir)->stat or return 0;
    }
    return 1;
}

sub build
{
    my ($self) = @_;
    my $basedir = $self->get_dependency('basedir')->basedir;

    foreach my $dir (@{$self->dir_list}) {
        Path::Class::Dir->new($basedir,$dir)->mkpath;
    }
}

sub forProject
{
    my ($class,$build) = @_;
    $class->new(package_path => $build->package_path);
}

no Moose;
1;

__END__

