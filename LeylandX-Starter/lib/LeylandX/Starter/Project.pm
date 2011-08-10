  package LeylandX::Starter::Project
# **********************************
; our $VERSION = '0.01';
# **********************
use Moose;

has package_name =>
(
    is => 'ro',
    isa => 'Str',
    required => 1
);

has app_name =>
(
    is => 'ro',
    isa => 'Str',
    lazy => 1,
    default => sub {
        my $app_name = shift->package_name;
        $app_name =~ s/::/-/g;
        return $app_name;
    }
);

has package_path =>
(
    is => 'ro',
    isa => 'Str',
    lazy => 1,
    default => sub {
        my $package_path = shift->package_name;
        $package_path =~ s!::!/!g;
        return $package_path;
    }
);

has root_dir =>
(
    is => 'ro',
    isa => 'Str',
    required => 1
);

has author =>
(
    is => 'ro',
    isa => 'Str'
);

has email =>
(
    is => 'ro',
    isa => 'Str'
);

has abstract =>
(
    is => 'ro',
    isa => 'Maybe[Str]',
    default => ''
);

has override_context =>
(
    is => 'ro',
    isa => 'HashRef',
    default => sub { {enabled => 0} },
    documentation => 'If or not an overridden context class is used'
);

no Moose;
1;

__END__

