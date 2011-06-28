package LeylandX::Starter::Controller::Features;

use Moose;
use Leyland::Parser;
use namespace::autoclean;

use boolean;

with 'Leyland::Controller';

prefix { '/features' }

get '^/with_hfh$' {
    $c->template('features/with_hfh.html',{},false);
}

get '^/with_context$' {
    $c->template('features/with_context.html',{},false);
}

1;

__END__


