package Cosmos::Controller::Root;

use Moose;
use Leyland::Parser;
use namespace::autoclean;

with 'Leyland::Controller';

use Data::Dumper;

prefix { '' }

get '^/$' {
  $c->template('index.html');
}

get '^/user/(\w+)$' {
  my $user = $c->stash->{'user'} = shift;
  $c->stash->{'repos'} = $c->get_user_repos($user);
  $c->template('index.html');
}

sub auto {
	my ($self, $c) = @_;

}

sub pre_route {
	my ($self, $c) = @_;

}

sub pre_template {
	my ($self, $c, $tmpl, $context, $use_layout) = @_;

}

sub post_route {
	my ($self, $c, $ret) = @_;

}

__PACKAGE__->meta->make_immutable;

__END__

=head1 NAME

Cosmos::Controller::Root - Top level controller of Cosmos

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 PREFIX

I<none, this is the root controller>

=head1 ROUTES

=head2 GET /

Returns text/html

=head1 METHODS

=head2 auto( $c )

=head2 pre_route( $c )

=head2 pre_template( $c, $tmpl, [ \%context, $use_layout ] )

=head2 post_route( $c, $ret )

=head1 AUTHOR

Sebastian Knapp, C<< <rock@ccls-online.de> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-Cosmos at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Cosmos>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

	perldoc Cosmos::Controller::Root

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
