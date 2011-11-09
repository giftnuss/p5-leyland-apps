  package Teddy::Session::State;
# ******************************
  our $VERSION = '0.01';
# **********************
use strict; use warnings;
use parent 'Plack::Session::State::Cookie';

sub session_key { 'teddy_session' }

sub expires { 3600 * 24 * 60 }

1;

__END__

