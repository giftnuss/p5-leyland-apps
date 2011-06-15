package LeylandX::Languages;

our $VERSION = "0.001";
$VERSION = eval $VERSION;

use Moose;
use namespace::autoclean;

extends 'Leyland';

use LeylandX::Languages::Localizer;

sub setup {
	my $self = shift;

	# init localizer, if localization path given
	$self->_set_localizer(LeylandX::Languages::Localizer->new(path => $self->config->{locales}))
		if exists $self->config->{locales};
}


=head1 NAME

LeylandX::Languages - RESTful web application based on Leyland

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 EXTENDS

L<Leyland>

=head1 METHODS

=head2 setup()

=head1 AUTHOR

Some Guy, C<< <some_guy@email.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-LeylandX-Languages at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=LeylandX-Languages>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

	perldoc LeylandX::Languages

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=LeylandX-Languages>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/LeylandX-Languages>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/LeylandX-Languages>

=item * Search CPAN

L<http://search.cpan.org/dist/LeylandX-Languages/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2011 Some Guy.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

__PACKAGE__->meta->make_immutable;
