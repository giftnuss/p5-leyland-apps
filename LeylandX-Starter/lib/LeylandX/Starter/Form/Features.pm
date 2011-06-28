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
  return q[
function () {
  var ids = ['with_context','with_hfh'];

  for(var c = 0; c < 2; ++c) {
     (function (action,option) {
  
         $('#' + action).bind('change',function (evt) {
             var self = this;
             if(option) {
                 $('#' + option).toggle(self.checked);
             }
             else {
                 $.get('features/' + action, function (data,status,xhr) {
                     option = 'feature-' + action;
                     $(self).parent().append('<div id="' + option + '">' + data + '</div>');
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

