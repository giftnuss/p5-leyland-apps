package Cosmos::Context;
# Abstract: Provides an extensible context object for your Leyland application

our $VERSION = "0.001";
$VERSION = eval $VERSION;

use Moose;
extends 'Leyland::Context';

use Pithub;

# no access with user token?
my $token = $ENV{'GITHUB_API_TOKEN'};
my $pithub;

sub pithub {
  unless($pithub) {
    $pithub = Pithub->new();
  }
  return $pithub;
}

sub get_user_repos {
  my ($self,$username) = @_;

  my $result = Pithub::Repos->new(
    per_page => 100,
    auto_pagination => 1,)->list(user => $username);
  if($result->success) {
    return $result;
  }
  return undef;
}

__PACKAGE__->meta->make_immutable;
no Moose;

1;

__END__

=head1 NAME

Cosmos::Context - Provides an extensible context object for your Leyland application

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


