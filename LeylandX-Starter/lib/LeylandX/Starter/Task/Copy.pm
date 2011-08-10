  package LeylandX::Starter::Task::Copy
# *************************************
; our $VERSION = '0.01';
# **********************
use Moose::Role;

with 'LeylandX::Starter::Task::Component::FileMap';

use File::Copy ();

sub forProject
{
    my ($class,$project) = @_;
    return $class->new;
}

sub build
{
    my ($self) = @_;
    my $basedir = $self->get_dependency('basedir')->basedir;

    foreach my $src (keys %{$self->file_map}) {
        my $file = Path::Class::File->new($basedir,$self->file_map->{$src});
        next if $file->stat;

        $file->dir->mkpath();
	File::Copy::copy($src,"$file");
    }
}

no Moose::Role;

1;

__END__

 
