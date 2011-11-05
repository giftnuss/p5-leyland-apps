
use strict;
use warnings;
use Leyland::Test;
use Test::More;

app('Teddy');

use Data::Dumper;

#print Dumper(&app);

done_testing();

__END__

my $c;
my $handler = sub {
    my $env = shift;
    # create the context object
    $c = $app->context_class->new(
        app => $app,
        env => $env,
        num => 1
    );
    $c->_respond(undef, undef, 'Hello World');
};

test_psgi( $handler, sub {
          my $cb = shift;
          my $req = HTTP::Request->new(GET => "/");
          my $res = $cb->($req);
          like $res->content, qr/Hello World/,'Dummy context created';
});

my $photoform = $c->form('photo');

isa_ok($photoform,'Teddy::Form::Photo');

done_testing();
