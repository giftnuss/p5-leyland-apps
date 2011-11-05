
use strict;
use warnings;
use Plack::Test;

use Teddy;

$ENV{'PLACK_ENV'} = 'staging';

my $app = Teddy->new(
    cwe => 'staging',
    config => {
        app => 'Teddy',
        logger => {			
                class => 'LogDispatch',
		opts => {
		    outputs => [
			[ 'Screen', min_level => 'warning', newline => 1 ],
		]}
	}
    });

$app->setup();

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
