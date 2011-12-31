package Cosmos;
# Abstract: Github Code Restaurant

our $VERSION = "0.001";
$VERSION = eval $VERSION;

use Moose;
use namespace::autoclean;

extends 'Leyland';

use Cosmos::Context;

has '+context_class' => (
  default => 'Cosmos::Context'
);

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

=head1 NAME

Cosmos - RESTful web application based on Leyland

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 EXTENDS

L<Leyland>

=head1 METHODS

=head2 setup()

=head1 AUTHOR

Sebastian Knapp, C<< <rock@ccls-online.de> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-Cosmos at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Cosmos>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

	perldoc Cosmos

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Cosmos>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Cosmos>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Cosmos>

=item * Search CPAN

L<http://search.cpan.org/dist/Cosmos/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2011 Sebastian Knapp.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


