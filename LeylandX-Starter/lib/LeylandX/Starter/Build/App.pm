  package LeylandX::Starter::Build::App
# *************************************
; our $VERSION = '0.01';
# **********************
use Moose;
with 'LeylandX::Starter::Task::Files';

has '+file_map' =>
(
    default => sub {{
        'App.pm' => 'App.pm'
    }}
);

sub forProject
{
    my ($self,$project) = @_;
    my $opts = {
        app_name => $project->app_name,
        package_name => $project->package_name,
        author => $project->author,
        email => $project->email,
        abstract => $project->abstract
    };
    my $task = $self->new(opts => $opts);
    $task->file_map->{'App.pm'} = 'lib/' . $project->package_path . '.pm';
    return $task;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__DATA__

_____[ App.pm ]_________________________________________________________
package [== $package_name =];
# Abstract: [== $abstract =]

our $VERSION = "0.001";
$VERSION = eval $VERSION;

use Moose;
use namespace::autoclean;

extends 'Leyland';

sub setup {
	my $self = shift;
	
	# this method is automatically called after the application has
	# been initialized. you can perform some necessary initializations
	# (like database connections perhaps) and other operations that
	# are only needed to be performed once when starting the application.
	# you can remove it completely if you don't use it.
}

__PACKAGE__->meta->make_immutable;

__END__

!=head1 NAME

[== $package_name =] - RESTful web application based on Leyland

!=head1 SYNOPSIS

!=head1 DESCRIPTION

!=head1 EXTENDS

L<Leyland>

!=head1 METHODS

!=head2 setup()

!=head1 AUTHOR

[== $author =], C<< <[== $email =]> >>

!=head1 BUGS

Please report any bugs or feature requests to C<bug-[== $app_name =] at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=[== $app_name =]>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

!=head1 SUPPORT

You can find documentation for this module with the perldoc command.

	perldoc [== $package_name =]

You can also look for information at:

!=over 4

!=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=[== $app_name =]>

!=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/[== $app_name =]>

!=item * CPAN Ratings

L<http://cpanratings.perl.org/d/[== $app_name =]>

!=item * Search CPAN

L<http://search.cpan.org/dist/[== $app_name =]/>

!=back

!=head1 LICENSE AND COPYRIGHT

Copyright [== (localtime)[5]+1900 =] [== $author =].

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


