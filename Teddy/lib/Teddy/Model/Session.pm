  package Teddy::Model::Session;
# ******************************
  our $VERSION = '0.01';
# **********************
use Moose;

with 'LeylandX::Database';

sub load_by_id
{
    my ($self,$id) = @_;
    my ($session) = $self->get_by_id($id);
    unless($session) {
        $self->insert_id($id);
        $session = $self->get_by_id($id);
    }
    return $session;
}

sub get_by_id
{
    my ($self,$id) = @_;
    my $sql = "SELECT session_id from session WHERE id = ?";
    $self->run(sub { $_->selectrow_array($sql,{},$id); });
}

sub insert_id
{
    my ($self,$id) = @_;
    my $insert = "INSERT INTO session (id) VALUES(?)";
    $self->run(sub { $_->do($insert,{},$id) });
}

no Moose;

__PACKAGE__->meta->make_immutable;

1;

__END__

=head2 load_by_id

Retrieves the internal session id (integer) by session id string. If there
is no such record it creates one.
