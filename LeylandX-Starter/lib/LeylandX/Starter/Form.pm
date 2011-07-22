package LeylandX::Starter::Form;
use Moose;

extends 'HTML::FormHandler';

has 'context' =>
(
    is => 'rw',
    isa => 'Leyland::Context'
);

sub _self_id
    {
        my $class = blessed(shift);
        my $sep = shift || '::';
        my $pos = index($class,'Form::') + 6;
        $pos = $[ if $pos < $[;
        my $action = lc(substr($class,$pos));
        $action =~ s/::/$sep/g;
        return $action;
    }

has '+action' => (default => sub { shift->_self_id('/') });

has '+name' => (default => sub { shift->_self_id('_') });

# - customize me ;)
# has '+widget_wrapper' => (default => 'None');

sub localize_meth 
{
    my ($field,$msg,@args) = @_;
    # use it as it is
    # $msg =~ s/\[_(\d+)\]/%$1/g;
    
    return $field->form->context->loc($msg,@args);
}


__PACKAGE__->meta->make_immutable;
no Moose;

1;

__END__


