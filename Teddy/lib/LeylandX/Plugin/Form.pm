package LeylandX::Plugin::Form;

use Moose::Role;

use Module::Pluggable;

requires 'app';

has form_ns =>
(
    is => 'rw',
    isa => 'Str',
    lazy => 1,
    default => sub {
        my ($self) = @_;
        blessed( $self->app ) . '::Form';
    }
);

has forms =>
(
    is => 'ro',
    isa => 'HashRef',
    lazy => 1,
    builder => 'load_forms',
    predicate => 'has_forms'
);

sub load_forms {
    my ($self,$namespace) = @_;
    $namespace ||= $self->form_ns;
    my $forms = $self->has_forms ? $self->forms : {};

    my $finder = Module::Pluggable::Object->new(
            search_path => [$namespace],
            require => 1
    );

    foreach my $formclass ($finder->plugins) {
        my $name = lc(substr($formclass,length($namespace)));
        $name =~ s/^:://;
        $name =~ s/::/-/;
        $forms->{$name} = $formclass;
    }
    return $forms;
}

sub form {
    my ($self,$name,@args) = @_;
    my $forms = $self->forms;
    return undef unless defined $forms->{$name};
    return $forms->{$name} if blessed $forms->{$name};
    $forms->{$name} = $forms->{$name}->new(@args);

    # in leyland it is common to give the current context to the form
    # for further usage.
    if( $forms->{$name}->can('context') ) {
        $forms->{$name}->context($self);
    }
    return $forms->{$name}
}

no Moose::Role;
1;

__END__
