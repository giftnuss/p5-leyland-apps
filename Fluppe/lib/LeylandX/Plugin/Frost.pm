package LeylandX::Plugin::Frost;

use Moose::Role;
use MooseX::Types::Path::Class;

use Data::Structure::Util qw( unbless );
use Clone qw( clone );
use Try::Tiny;
use autodie;

use namespace::autoclean;

requires 'json';

has frost_dir => (
    is => 'ro',
    isa => 'Path::Class::Dir',
    lazy => 1,
    coerce => 1,
    default => sub {
        my $self = shift;
        my $path = Path::Class::Dir->new('./frost');
        $path->stat || $path->mkpath ||
            die("Initialize frost dir failed: $!");
        return $path;
    }
);

sub thaw {
    my ($self,$key) = @_;

    my $file = $self->frost_dir->file($key);

    my $data;
    try {
        $data = $self->json->from_json(
            do { local $/; readline($file->openr) } );
    }
    catch {
        warn $_;
        return;
    };

    if(my $class = $data->{'class'}) {
        return bless $class, $data->{'object'}
    }
    else {
        return $data->{'object'}
    }
}

sub freeze {
    my ($self,$key,$object) = @_;

    my $file = $self->frost_dir->file($key);
    my $data;
    if(my $class = blessed $object) {
        $data = { class => $class, object => unbless(clone($object)) }
    }
    else {
        $data = { class => undef, object => $object }
    }
    $file->openw()->print( $self->json->to_json($data) );
}

no Moose::Role;

1;

__END__

=head1 NAME

LeylandX::Plugin::Frost

=head1 SYNOPSIS

    # Your App
    package MyApp;
    use Moose;
    extends 'Leyland';
    with 'LeylandX::Plugin::Frost;

    # Somewhere in a controller
    get '^/refresh' {
        $c->stash->{data} = $c->thaw('appdata');
        $c->template('refresh.html');
    }
