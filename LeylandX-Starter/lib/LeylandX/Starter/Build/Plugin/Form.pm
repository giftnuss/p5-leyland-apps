  package LeylandX::Starter::Build::Plugin::Form
# **********************************************
; our $VERSION = '0.01';
# **********************
use Moose;
extends 'LeylandX::Starter::Task';
with 'LeylandX::Starter::Task::Copy';

use namespace::autoclean -except => 'meta';

use Cwd qw( getcwd );

has '+name' =>
(
    default => 'plugin_form'
);

has '+file_map' =>
(
    default => sub {
        my $srcbase = getcwd();
        return {
            $srcbase . '/lib/LeylandX/Plugin/Form.pm' =>
                'lib/LeylandX/Plugin/Form.pm'
    }}
);

no Moose;

1;

__END__

