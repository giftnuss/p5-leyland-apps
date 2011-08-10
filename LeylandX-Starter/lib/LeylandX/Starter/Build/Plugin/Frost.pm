  package LeylandX::Starter::Build::Plugin::Frost
# ***********************************************
; our $VERSION = '0.01';
# **********************
use Moose;
extends 'LeylandX::Starter::Task';
with 'LeylandX::Starter::Task::Copy';

use Cwd qw( getcwd );

use namespace::autoclean -except => 'meta';

has '+name' =>
(
    default => 'plugin_frost'
);

has '+file_map' =>
(
    default => sub {
        my $srcbase = getcwd();
        return {
            $srcbase . '/lib/LeylandX/Plugin/Frost.pm' =>
                'lib/LeylandX/Plugin/Frost.pm'
    }}
);


no Moose;

1;

__END__

