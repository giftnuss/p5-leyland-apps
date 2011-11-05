package Leyland::Test;
 
use strict;
use warnings;
use 5.010;

BEGIN {
    $ENV{'PLACK_ENV'} //= 'staging';
};

use Test::More ();
 
use Plack::Test;
use Exporter::Lite;
use Class::Load ();

our @EXPORT = qw(app test_psgi);

use Carp 'croak', 'carp';

{
    my $app;

    sub app {
        my ($name,%args) = @_;
        if($name) {
            $args{'config'} = _default_config($name,$args{'config'});

	    Class::Load::load_class($name);
	    $app = $name->new(%args);
	}
        return $app;
    }

    sub _default_config {
        my ($name,$config) = (@_,{});
        $config->{'app'} //= $name;
        $config->{'locales'} //= './i18n',
        $config->{'logger'} ||= {
            class => 'LogDispatch',
            opts => {
                outputs => [
			[ 'Screen', min_level => 'warning', newline => 1 ],
		]}
        };
        return $config;
    }
};

1;

__END__

