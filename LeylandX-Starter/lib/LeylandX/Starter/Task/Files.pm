  package LeylandX::Starter::Task::Files
# **************************************
; our $VERSION = '0.01';
# **********************
use Moose::Role;
with 'LeylandX::Starter::Task::Component::FileMap',
     'LeylandX::Starter::Task::Template';

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

no Moose::Role;
1;

__END__

