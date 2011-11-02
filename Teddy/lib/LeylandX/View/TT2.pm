  package LeylandX::View::TT2;
# ****************************
  our $VERSION = '0.01';
# **********************
# ABSTRACT: Template Toolkit view class for Leyland

use Moose::Role;
use Template ();

has 'engine' =>
(
  is => 'ro',
  isa => 'Template',
  builder => '_init_engine'
);

has 'localizer' =>
(
  is => 'rw',
  isa => 'Leyland::Localizer',
  writer => 'set_localizer'
);

after 'set_localizer' => sub {
  my ($self) = @_;
  $self->engine->{SERVICE}->{CONTEXT}->{LOCALIZER} = $self->localizer;
};

sub render
{
    my ($self, $view, $context, $use_layout) = @_;
    my $output;

    $use_layout = 1 unless defined $use_layout;

    if(!$use_layout) {
        local $self->engine->{SERVICE}->{'WRAPPER'} = [];
        if(! $self->engine->process($view, $context,\$output)) {
            warn $self->engine->error;
        }
    }
    else {
        if(! $self->engine->process($view, $context,\$output)) {
            warn $self->engine->error;
        }
    }

    return $output;
}

use Data::Dumper;
my $i18n = sub {
  my ($context,@args) = @_;
  
  return sub {
    my $content = shift;
    my $lc = $context->stash->{c};
    my $lang;
    if($lc) {
        $lang = $lc->{lang};
    }
    $lang ||= 'en';   
    $context->{LOCALIZER}->loc($content,$lang,@args);
  } 
};

sub _init_engine
{
    return Template->new({
        INCLUDE_PATH => ['./views'],
        ENCODING => 'utf8',
        WRAPPER => 'layouts/main.html',
	FILTERS => {
	    l => [$i18n, 1],
	    loc => [$i18n, 1],
            i18n => [$i18n, 1]
        }
    });
}

1;

__END__
