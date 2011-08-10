  package LeylandX::Starter::Build::Context
# *****************************************
; our $VERSION = '0.01';
# **********************
use Moose;
extends 'LeylandX::Starter::Task';
with 'LeylandX::Starter::Task::Files';

use Class::Load qw( load_class );

use namespace::autoclean -except => 'meta';

sub forProject
{
    my ($self,$project) = @_;
    unless($project->override_context->{enabled}) {
        return undef;
    }
    my $opts = {
        app_name => $project->app_name,
        package_name => $project->package_name . "::Context",
        author => $project->author,
        email => $project->email,
        abstract => "Provides an extensible context object for your Leyland application"
    };
    my $task = $self->new(opts => $opts);
    $task->file_map->{'Context.pm'} = 'lib/' . $project->package_path . '/Context.pm';

    my @plugins = (
        ['plugin_frost' => 'LeylandX::Starter::Build::Plugin::Frost'],
        ['plugin_form' => 'LeylandX::Starter::Build::Plugin::Form']
    );

    foreach my $row (@plugins) {
        my $name = $row->[0];
        my $class = $row->[1];
        if($project->override_context->{$name}) {
            $task->add_dependency($name);
            load_class($class);
            $task->add_subtask($class);
        }
    }
    return $task;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__DATA__

_____[ Context.pm ]_____________________________________________________
package [== $package_name =];
# Abstract: [== $abstract =]

our $VERSION = "0.001";
$VERSION = eval $VERSION;

use Moose;
extends 'Leyland::Context';

__PACKAGE__->meta->make_immutable;
no Moose;

1;

__END__

!=head1 NAME

[== $package_name =] - [== $abstract =]

!=head1 SYNOPSIS

!=head1 DESCRIPTION

!=head1 EXTENDS

L<Leyland::Context>

!=head1 METHODS

!=head1 AUTHOR

[== $author =], C<< <[== $email =]> >>

!=head1 LICENSE AND COPYRIGHT

Copyright [== (localtime)[5]+1900 =] [== $author =].

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


