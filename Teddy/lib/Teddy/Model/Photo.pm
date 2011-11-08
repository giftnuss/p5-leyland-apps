  package Teddy::Model::Photo;
# ****************************
  our $VERSION = '0.01';
# **********************
use Moose;

with 'LeylandX::Database';

sub md5_not_exists {
    my ($self,$md5) = @_;
    my $sql = 'SELECT photo_id FROM photo WHERE md5 = ?';

    return $self->database->run(sub {
        my ($result) = $_->selectrow_array($sql,$md5);
        return $result
    });
}

no Moose;

__PACKAGE__->meta->make_immutable;

1;

__END__

