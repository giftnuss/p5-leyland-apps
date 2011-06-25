  package LeylandX::Starter::Form::Features;
# ******************************************
  our $VERSION = '0.01';
# **********************
use HTML::FormHandler::Moose;
extends 'LeylandX::Starter::Form';


has_field with_context =>
   (
        type => 'Boolean',
        label => 'Extend Context Class',
        default => 0
   );

has_field with_hfh => 
    (
      type => 'Boolean',
      label => 'With HTML::FormHandler',
      default => 0
    );

no HTML::FormHandler::Moose;

1;

__END__

