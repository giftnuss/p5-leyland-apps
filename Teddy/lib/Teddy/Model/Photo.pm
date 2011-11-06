  package Teddy::Model::Photo;
# ****************************
  our $VERSION = '0.01';
# **********************
use Moose;

sub md5_not_exists {
    my ($self,$md5) = @_;   
}

no Moose;

__PACKAGE__->meta->make_immutable;

1;

__END__

