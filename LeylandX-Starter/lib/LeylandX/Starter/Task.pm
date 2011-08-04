  package LeylandX::Starter::Task
# *******************************
; our $VERSION = '0.01';
# **********************
use Moose::Role;

has name =>
(
   is => 'ro',
   isa => 'Str',
   default => sub {
      my $class = blessed shift();
      return lc(substr($class,rindex($class,'::')+2))
   }
);

has dependencies =>
(
   is => 'ro',
   isa => 'HashRef[LeylandX::Starter::Task]',
   default => sub { {} }
);

has subtasks =>
(
   traits => ['Array'],
   is => 'ro',
   isa => 'ArrayRef[Str]',
   default => sub { [] }
);

sub plugins
{
    return @{shift->subtasks};
}

sub set_dependency
{
    my ($self,$name,$task) = @_;
    $self->dependencies->{$name} = $task;
}

sub get_dependency
{
    my ($self,$name) = @_;
    return $self->dependencies->{$name};
}

no Moose::Role;
1;

__END__
