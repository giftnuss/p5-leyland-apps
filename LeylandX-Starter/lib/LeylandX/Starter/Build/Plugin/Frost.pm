  package LeylandX::Starter::Build::Plugin::Frost
# ***********************************************
; our $VERSION = '0.01';
# **********************
use Moose;
extends 'LeylandX::Starter::Task';
with 'LeylandX::Starter::Task::Copy';

has '+name' =>
(
    default => 'plugin_frost'
);

no Moose;

1;

__END__

