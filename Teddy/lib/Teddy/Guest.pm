  package Teddy::Guest;
# *********************
  our $VERSION = '0.01';
# **********************
use Moose;

has model =>
(
  is => 'ro',
  isa => 'Teddy::Model',
  required => 1,
  handles => { with => 'model' }
);

has session_id =>
(
  is => 'rw',
  isa => 'Int'
);

sub start_session
{
    my ($self,$id) = @_;
    $self->session_id($self->with('session')->load_by_id($id)); 

}

no Moose;

__PACKAGE__->meta->make_immutable();

1;
