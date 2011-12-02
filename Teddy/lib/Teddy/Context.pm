  package Teddy::Context;
# ***********************
  our $VERSION = "0.001";
# ***********************
$VERSION = eval $VERSION;

use Moose;
extends 'Leyland::Context';

with 'LeylandX::Plugin::Form';

has photo =>
(
  is => 'rw',
  does => 'Teddy::Role::Item',
  lazy => 1,
  default => sub { new Teddy::Photo }
);

has '+user' =>
(
    default => sub {
        my ($self) = @_;
        my $user = $self->app->new_guest;

        # using my special store makes this hack possible
        if(ref $self->session) {
            # erster Klick oder keine Cookies aktiv
            #
            # nur unnötige redundanz $user->start_session($self->session_id);
        }
        else {
            # nicht der erste Klick und Cookie war in DB
        }
        $user
    }
);

sub session_id
{
    shift->env->{'psgix.session.options'}{'id'};
}

sub session
{
    shift->env->{'psgix.session'}
}

no Moose;

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Teddy::Context - Provides an extensible context object for your Leyland application

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 EXTENDS

L<Leyland::Context>

=head1 METHODS

=head2 session

Returns a hashref with current session data.

=head1 AUTHOR

Sebastian Knapp, C<< <rock@ccls-online.de> >>

=head1 LICENSE AND COPYRIGHT

Copyright 2011 Sebastian Knapp.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


