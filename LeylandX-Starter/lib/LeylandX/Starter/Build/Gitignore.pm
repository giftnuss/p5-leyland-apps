  package LeylandX::Starter::Build::Changes
# *****************************************
; our $VERSION = '0.01';
# **********************
use Moose;
with 'LeylandX::Starter::Task::Files';

has '+file_map' =>
(
    default => sub {{
        gitignore => '.gitignore'
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

__DATA__

_____[ gitignore ]__________________________________________________
^blib/.*$
^inc/.*$
^Makefile$
^Makefile\.old$
^pm_to_blib$
^Build$
^Build\.bat$
^_build\.*$
^pm_to_blib.+$
^.+\.tar\.gz$
^\.lwpcookies$
^cover_db$
^pod2htm.*\.tmp$
^[== $app_name =]-.*$
^[._]build/.*$
^MYMETA.yml$
^.*\.bak$
^views/.*\.cache$
^.*\.log$
