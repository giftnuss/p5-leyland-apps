package LeylandX::Starter::Form;
use Moose;

extends 'HTML::FormHandler';

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

has '+name' => (default => sub { shift->_self_id('_') . '_form' });

__PACKAGE__->meta->make_immutable;
no Moose;

1;

__END__


