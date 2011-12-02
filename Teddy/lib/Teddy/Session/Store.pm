  package Teddy::Session::Store;
# ******************************
  our $VERSION = '0.01';
# **********************
use Moose;

extends 'Plack::Session::Store';

has app =>
(
    is => 'ro',
    isa => 'Leyland',
    required => 1
); 

sub fetch
{
    my ($self, $id) = @_;
    my $session = $self->app->get_model('session');
    my $dd = $session->load_by_id($id);
    warn "$dd $id";
    return $dd;
}

sub store { }

sub remove { }

no Moose;

1;

__END__
