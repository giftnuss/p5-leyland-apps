package Leyland::View::Solution;

# ABSTRACT: Solutio template view class for Leyland

use Moose;
use namespace::autoclean;

use Solution 0.0004;
use Path::Class;
use autodie;

=head1 NAME

Leyland::View::Solution - Solution view class for Leyland

=head1 SYNOPSIS

    # in app.psgi:
    my $config = {
    ...
	views => ['Solution'],
    ...
    };

=head1 DESCRIPTION

This module uses the L<Solution> template engine to render views.
Solution is a template engine based on Liquid. It is simple and
stateless.

=head1 CONSUMES

L<Leyland::View>

=cut

with 'Leyland::View';

has default_layout => (is => 'ro', isa => 'Str', default => 'layouts/main.html');

my %documents;

sub render {
    my ($self,$view,$context,$use_layout) = @_;
    $use_layout = 1 unless defined $use_layout;

    my $content = $self->parse_view($view)->render($context);

    unless($use_layout eq '0') {
        $view = delete($context->{'_layout'}) || $use_layout;
        $view = $self->default_layout if $view eq '1';
        $context->{'_content'} = $content;
        $content = $self->render($view,$context,0);
    }

    return $content;
}

sub parse_view {
    my ($self,$view) = @_;

    unless(exists($documents{$view})) {
        my ($src) = $self->load_view($view);
        $documents{$view} = Solution::Template->new->parse($src);     
    }
    return $documents{$view};
}

sub load_view {
    my ($self,$view) = @_;
    my $io = file("views",$view)->open('r');
    $io->binmode(':utf8');
    local $/;
    my ($src) = $io->getlines();
    return $src;
}

__PACKAGE__->meta->make_immutable;

