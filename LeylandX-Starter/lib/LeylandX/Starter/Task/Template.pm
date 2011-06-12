  package LeylandX::Starter::Task::Template
# *****************************************
; our $VERSION = '0.01';
# **********************
use Moose::Role;

has tenjin => (
   is => 'rw',
   isa => 'Tenjin',
   reader => 'get_tenjin',
   writer => 'set_tenjin'
);

has opts =>
(
    is => 'ro',
    isa => 'HashRef',
    required => 1
);

sub render_file
{
    my ($self,$file,$tmplname) = @_;

    my $fh = $file->open('>:utf8') or
        die("Opening template file $file failed. $!");
    $fh->print($self->get_tenjin->render($tmplname,$self->opts));
}

no Moose::Role;
1;

__END__

