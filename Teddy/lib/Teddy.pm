package Teddy;
# Abstract: Toy app

our $VERSION = "0.001";
$VERSION = eval $VERSION;

use Moose;
use namespace::autoclean;

use Teddy::Model;
use LeylandX::Languages::Localizer;

extends 'Leyland';

has model =>
(
  is => 'ro',
  isa => 'Teddy::Model',
  default => sub { Teddy::Model->new() }
);

sub setup
{
  my $self = shift;
  $self->model->setup_database($self->cwe, $self->config);

  # init localizer, if localization path given
  $self->_set_localizer(LeylandX::Languages::Localizer->new(path => $self->config->{locales}))
        if exists $self->config->{locales};

  foreach my $view ($self->views) {
    $view->set_localizer($self->localizer) if $view->can('set_localizer');
  }
}

__PACKAGE__->meta->make_immutable;

__END__

=head1 NAME

Teddy - RESTful web application based on Leyland

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 EXTENDS

L<Leyland>

=head1 METHODS

=head2 setup()

=head1 AUTHOR

Sebastian Knapp, C<< <rock@ccls-online.de> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-Teddy at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Teddy>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

	perldoc Teddy

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


