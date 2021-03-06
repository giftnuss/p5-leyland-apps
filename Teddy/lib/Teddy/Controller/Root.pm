package Teddy::Controller::Root;

use Moose;
use Leyland::Parser;
use namespace::autoclean;

with 'Leyland::Controller';

use Teddy::Photo;

prefix { '' }

# fresh start page
get '^/$' {
  $c->template('index.html');
}

# foundation demo site
get '^/demo$' {
  $c->template('foundation.html');
}

# if you want to give something away
get '/give/away$' {
  $c->template('give.html');
}

# if you upload a photo
get '/give/photo/?(\d+)?$' {
  my ($photoid) = shift;
  if($photoid) {
    $c->photo->load($photoid);
  }
  if($c->photo->loaded()) {
    $c->template('describe.html');
  }
  else {
    $c->template('error.html');
  }
}

=head1 METHODS

=head2 auto( $c )

=cut

sub auto {
	my ($self, $c) = @_;
	# this method is automatically called before the actual route method
	# is performed. every auto() method starting from the Root controller
	# and up to the matched route's controller are invoked in order,
	# so this auto() method (in the Root controller) will run for
	# every request, no matter what the request is for, so you can use
	# it to perform some necessary per-request operations like perhaps
	# validating a user's authorization to perform an operation
}

=head2 pre_route( $c )

=cut

sub pre_route {
	my ($self, $c) = @_;

	# this method is automatically called before the actual route method
	# is performed, but only for route methods in this controller, as
	# opposed to the auto() method. the pre_route() method of a controller,
	# if exists, will always be performed after all auto() methods
	# have been invoked
}

=head2 pre_template( $c, $tmpl, [ \%context, $use_layout ] )

=cut

sub pre_template {
	my ($self, $c, $tmpl, $context, $use_layout) = @_;
        if(!defined($use_layout) || $use_layout) {
            $c->stash->{'tutor'} ||= 'Teddy';
            $c->stash->{'page_title'} ||=
                $c->loc("%1 helps you to give toys away.",$c->stash->{'tutor'}); 	
        }
	# this method is automatically called before a view/template is
	# rendered by routes in this controller. It receives all the
	# the Leyland context object ($c), the name of the view/template
	# to be rendered ($tmpl), and possibly the context hash-ref and
	# the use_layout boolean.
}

=head2 post_route( $c, $ret )

=cut

sub post_route {
	my ($self, $c, $ret) = @_;

	# this method is automatically called after the actual route method
	# is performed, but only for route methods in this controller.
	# it also receives a reference to the result returned by the route
	# method after serialization (even if it's a scalar, in which case $ret will be a reference
	# to a scalar).
}

=head1 AUTHOR

Sebastian Knapp, C<< <rock@ccls-online.de> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-Teddy at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Teddy>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

	perldoc Teddy::Controller::Root

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Teddy>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Teddy>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Teddy>

=item * Search CPAN

L<http://search.cpan.org/dist/Teddy/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2011 Sebastian Knapp.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

__PACKAGE__->meta->make_immutable;
