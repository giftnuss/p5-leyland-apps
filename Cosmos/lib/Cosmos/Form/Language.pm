  package Cosmos::Form::Language;
# ******************************
use HTML::FormHandler::Moose;

extends 'Cosmos::Form';

has_field language =>
(
    type => 'Multiple',
    label => 'Programming Language',
    html_attr => {
      'data-placeholder' => "Filter By Programming Language",
      'class' => 'chzn-select'
    }
);

sub options_language {
  return (0 => 'unknown', map { $_ => $_ } 
    qw(C Java JavaScript C# Perl PHP Ruby Python))
}

no HTML::FormHandler::Moose;

1;

__END__

