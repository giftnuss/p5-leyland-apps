  package Teddy::Form::Field::Photo;
# **********************************
  our $VERSION = '0.01';
# **********************

use Moose;

use Image::Info qw();

extends 'HTML::FormHandler::Field::Upload';

after validate => sub
{
    my ($self) = shift;
    
    my $info = Image::Info::image_info($self->value->path);
    if (my $error = $info->{error}) {
        my $msg = $self->get_message('problem_reading_image_information');
        $self->form->context->log("Can't parse uploaded image: $error"); 
        return $self->add_error($msg);
    }
    $self->value->{'info'} = $info;
};

no Moose;

__PACKAGE__->meta->make_immutable();

1;

__END__

