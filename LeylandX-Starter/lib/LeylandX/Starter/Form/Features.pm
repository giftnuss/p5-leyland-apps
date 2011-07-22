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

sub on_ready 
{
  my ($self) = @_;
  my $formname = $self->name;
  #my $val = $self->field('with_context')->value;
  return qq[
function () {

  /*  */

  var ids = ['with_context','with_hfh'];

  for(var c = 0; c < 2; ++c) {
     (function (action,option) {
blix.log('#${formname}.' + action);
         \$('#${formname}.' + action).bind('click',function (evt) {
blix.log('change');
             var self = this;
             if(option) {
                 \$('#' + option).toggle(self.checked);
             }
             else {
                 \$.get('features/' + action, function (data,status,xhr) {
                     option = '${formname}-content.' + action;
                     \$(self).parent().append('<div id="' + option + '">' + data + '</div>');
                 });
             }
         });
     })(ids[c]);
  }
}
]}

no HTML::FormHandler::Moose;

1;

__END__

