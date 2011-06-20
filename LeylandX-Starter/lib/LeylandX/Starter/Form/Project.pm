  package LeylandX::Starter::Form::Project;
# *****************************************
  our $VERSION = '0.01';
# **********************
use HTML::FormHandler::Moose;
extends 'LeylandX::Starter::Form';

use File::Basename ();
use Cwd ();

has_field module =>
    (
        type => 'Text',
        label => 'Fresh Leyland Application',
        required => 1,
        apply => [
            { 
              transform => sub { 
                  $_[0] =~ s/^\W*//; $_[0] =~ s/\W*$//;
                  $_[0] =~ s/\W+/::/gs;
                  return $_[0];
              },
              message => 'Transformed...'
            },
            {
              check => sub { $_[0] =~ /^\w+(::\w+)+$/ },
              message => 'Invalid Application Name' 
            }
        ]
    );

has_field directory =>
    (
        type => 'Text',
        label => 'Base Dir',
        size => 40,
        set_validate => 'check_dir_is_writable'
    );

has_field with_context =>
   (
        type => 'Boolean',
        label => 'Create context class',
   );

has_field start =>
    (
        type => 'Submit',
        value => 'Start'
    );

sub default_directory
{
    File::Basename::dirname( Cwd::getcwd );
}

sub check_dir_is_writable
{
    my $self = shift;
    my $field = $self->field('directory');
    my $dir = $field->value;
    unless(-d $dir && -w $dir) {
        $field->add_error('Directory is not writable.');
        return 0;
    }
    return 1
}

no HTML::FormHandler::Moose;
1;

__END__
