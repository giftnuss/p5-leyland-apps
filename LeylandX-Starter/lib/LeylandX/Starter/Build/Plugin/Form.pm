  package LeylandX::Starter::Build::Plugin::Form
# **********************************************
; our $VERSION = '0.01';
# **********************
use Moose;
extends 'LeylandX::Starter::Task';
with 'LeylandX::Starter::Task::Copy';

has '+name' =>
(
    default => 'plugin_form'
);

no Moose;

1;

__END__

