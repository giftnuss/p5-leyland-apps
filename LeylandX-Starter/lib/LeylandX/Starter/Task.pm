  package LeylandX::Starter::Task
# *******************************
; our $VERSION = '0.01';
# **********************
use Moose;

sub BUILD {}

has name =>
(
   is => 'ro',
   isa => 'Str',
   default => sub {
      my $class = blessed shift();
      return lc(substr($class,rindex($class,'::')+2))
   }
);

has dependslist =>
(
  traits => ['Array'],
  is => 'rw',
  isa => 'ArrayRef[Str]',
  default => sub {[]},
  handles => {
        add_dependency => 'push'
  },
  documentation => 'holds the dependency names'
);

sub depends
{
    my ($self) = @_;
    return @{$self->dependslist};
}

has dependencies =>
(
   traits => ['Hash'],
   is => 'ro',
   isa => 'HashRef[LeylandX::Starter::Task]',
   default => sub { {} },
   handles => {
     set_dependency => 'set',
     get_dependency => 'get'
   },
   documentation => 'holds the dependency objects'
);

has subtasks =>
(
   traits => ['Array'],
   is => 'ro',
   isa => 'ArrayRef[Str]',
   default => sub { [] },
   handles => {
     add_subtask => 'push'
   }
);

sub plugins
{
    return @{shift->subtasks};
}

no Moose;
1;

__END__
