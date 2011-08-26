package Fluppe::Context;
# Abstract: Provides an extensible context object for your Leyland application

our $VERSION = "0.001";
$VERSION = eval $VERSION;

use Moose;
extends 'Leyland::Context';

__PACKAGE__->meta->make_immutable;
no Moose;

1;

__END__

=head1 NAME

Fluppe::Context - Provides an extensible context object for your Leyland application

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 EXTENDS

L<Leyland::Context>

=head1 METHODS

=head1 AUTHOR

Sebastian Knapp, C<< <rock@ccls-online.de> >>

=head1 LICENSE AND COPYRIGHT

Copyright 2011 Sebastian Knapp.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


