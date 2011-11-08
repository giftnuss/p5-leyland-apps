  package Teddy::Photo;
# *********************
  our $VERSION = '0.01';
# **********************
use Moose;

use CHI;
use File::Slurp ();

# class attribute
{
    my $cwe = 'development';
    
    sub set_cwe { $cwe = $_[1] }
    sub cwe { $cwe }
};

has key =>
(
  is => 'ro',
  isa => 'Int'
);

my %size = (
  file => [],
  xxl => [1280,1024],
  xl => [1024,768],
  large => [640,480],
  medium => [320,240],
  small => [160,120],
  thumbnail => [80,80],
  icon => [32,32]
);

foreach my $name (keys %size)
{
  has "cache_$name" =>
  (
    is => 'ro',
 #   isa => 'CHI::',
    default => sub {
      my $self = shift;
      CHI->new( 
         namespace => $name, driver => 'File',
         root_dir => './cache/' . $self->cwe);
    }
  );
}

sub create
{
    my ($self,$key,$file) = @_;
    my $data = File::Slurp::read_file($file,{binmode => ':raw'});
    $self->cache_file->set( $key, $data, "never");
    $self->{'key'} = $key;
}

no Moose;

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Teddy::Photo - the file and cache manager for the photos

