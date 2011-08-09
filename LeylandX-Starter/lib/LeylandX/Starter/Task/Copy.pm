  package LeylandX::Starter::Task::Copy
# *************************************
; our $VERSION = '0.01';
# **********************
use Moose::Role;

use File::Copy ();

sub forProject
{
    my ($class,$project) = @_;
    return $class->new;
}

no Moose::Role;

1;

__END__

 
