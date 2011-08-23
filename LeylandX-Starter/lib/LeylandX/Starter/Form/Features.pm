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

foreach my $plugin ('form','frost') {
    has_field "use_plugin_${plugin}" => (type => 'Boolean', widget => 'NoRender');
}

has_field with_hfh => 
    (
        type => 'Boolean',
        label => 'With HTML::FormHandler',
        default => 0
    );

has_field custom_form_base =>
(
    type => 'Boolean',
    widget => 'NoRender',
    default => 0
);

sub on_ready 
{
  my ($self) = @_;
  my $formname = $self->name;
  my $ids = $self->to_json;

  return qq[
function () {

  var ids = ${ids};

  for(var c in ids) {
     if(! c.match(/^with_/)) {
          continue;
     }
     (function (action,option) {
         \$('#${formname}').each(function () {
             \$('#' + action, this).bind('click',function (evt) {
                 var self = this;
                 if(option) {
                     \$('#' + option).toggle(self.checked);
                 }
                 else {
                     \$.get('features/' + action, function (data,status,xhr) {
                         option = '${formname}-content-' + action;
                         \$(self).parent().append('<div id="' + option + '">' + data + '</div>');
                         \$(':checkbox',\$('#' + option)).each(function () {
                             if(ids[this.name]) {
                                 this.checked = true;
                             }
                          });
                     });
                 }
             }).each(function () {
	         if(ids[c]) {
                     \$(this).trigger('click').attr('checked',true);
	         }
	     });
	 });
     })(c);
  }
}
]}

no HTML::FormHandler::Moose;

1;

__END__

