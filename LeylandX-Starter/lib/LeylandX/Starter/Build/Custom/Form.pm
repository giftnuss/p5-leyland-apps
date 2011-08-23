  package LeylandX::Starter::Build::Custom::Form
# **********************************************
; our $VERSION = '0.01';
# **********************
use Moose;
extends 'LeylandX::Starter::Task';
with 'LeylandX::Starter::Task::Files';

use namespace::autoclean -except => 'meta';

sub forProject
{
    my ($self,$project) = @_;
    unless($project->form_helper->{enabled}) {
        return undef;
    }
    my $opts = {
        app_name => $project->app_name,
        package_name => $project->package_name . "::Form",
        author => $project->author,
        email => $project->email,
        abstract => "Custom formular base class for your Leyland application"
    };
    my $task = $self->new(opts => $opts);
    $task->file_map->{'Form.pm'} = 'lib/' . $project->package_path . '/Form.pm';
    return $task;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__DATA__

_____[ Form.pm ]_____________________________________________________
package [== $package_name =];
# Abstract: [== $abstract =]

our $VERSION = "0.001";
$VERSION = eval $VERSION;

use Moose;
extends 'HTML::FormHandler';

has 'context' =>
(
    is => 'rw',
    isa => 'Leyland::Context'
);

sub to_json
{
    my ($self) = @_;
    return $self->context->json->to_json($self->value);
}

sub _self_id
    {
        my $class = blessed(shift);
        my $sep = shift || '::';
        my $pos = index($class,'Form::') + 6;
        $pos = $[ if $pos < $[;
        my $action = lc(substr($class,$pos));
        $action =~ s/::/$sep/g;
        return $action;
    }

has '+action' => (default => sub { shift->_self_id('/') });

has '+name' => (default => sub { shift->_self_id('_') });

# - customize me ;)
# has '+widget_wrapper' => (default => 'None');

sub localize_meth 
{
    my ($field,$msg,@args) = @_;
    # use it as it is
    # $msg =~ s/\[_(\d+)\]/%$1/g;
    
    return $field->form->context->loc($msg,@args);
}

__PACKAGE__->meta->make_immutable;
no Moose;

1;

__END__

!=head1 NAME

[== $package_name =] - [== $abstract =]

!=head1 SYNOPSIS

!=head1 DESCRIPTION

!=head1 EXTENDS

L<HTML::FormHandler>

!=head1 METHODS

!=head1 AUTHOR

[== $author =], C<< <[== $email =]> >>

!=head1 LICENSE AND COPYRIGHT

Copyright [== (localtime)[5]+1900 =] [== $author =].

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


