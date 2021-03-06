use strict;
use warnings;
use Test::More tests => 3;
use Plack::Test;

use 5.010;

$ENV{'PLACK_ENV'} = 'staging';

use Data::Dumper;

use LeylandX::Starter;

my $app = LeylandX::Starter->new(
    cwe => 'staging',
    config => {
        app => 'LeylandX::Starter',
        views => ['Tenjin'],
        logger => {			
                class => 'LogDispatch',
		opts => {
		    outputs => [
			[ 'Screen', min_level => 'warning', newline => 1 ],
		]}
	}
    });

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

my $authorform = $c->form('author');
my $projectform = $c->form('project');

isa_ok($authorform,'LeylandX::Starter::Form::Author');
isa_ok($projectform,'LeylandX::Starter::Form::Project');

# say Dumper($c);

#ok(1);
