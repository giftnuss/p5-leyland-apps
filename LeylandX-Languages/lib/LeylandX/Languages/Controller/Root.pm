package LeylandX::Languages::Controller::Root;

use Moose;
use Leyland::Parser;
use namespace::autoclean;

with 'Leyland::Controller';

prefix { '' }

get '^/$' {
    # $self and $c are automatically available for you here
    $c->template('index.html');
}

get '^/([a-z]{2})$' {
    my ($lang) = @_;
    $c->set_lang($lang);
    $c->forward('/');
}

get '^/([a-z]{3})$' {
    $c->template('index.html');
}

sub auto {
    my ($self, $c) = @_;

    # provide some defaults
    $c->set_lang('de');

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
=head1 NAME

LeylandX::Languages::Controller::Root - Top level controller of LeylandX-Languages

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 PREFIX

I<none, this is the root controller>

=head1 ROUTES

=head2 GET /

Returns text/html

=head1 METHODS

=head2 auto( $c )

Sets default language to 'de'.

=cut

=head1 AUTHOR

Some Guy, C<< <some_guy@email.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-LeylandX-Languages at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=LeylandX-Languages>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc LeylandX::Languages::Controller::Root

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
