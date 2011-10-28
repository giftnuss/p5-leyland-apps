  package Teddy::Define;
# **********************
  our $VERSION = '0.01';
# **********************
use strict; use warnings; use utf8;

use DBIx::Define table => undef;

############################
#        ACCESSORS         #
############################
sub schema {
  return DBIx::Define->get_schema('teddy');
}

sub translator {
  return DBIx::Define->translate('teddy');
}

sub sql_for {
  my ($self,$producer) = @_;
  my $translator = DBIx::Define->translate('teddy'); 
  return $translator->producer($producer)->($translator);
}
############################
#      DATABASE SCHEMA     #
############################
table('guest');

column( guest_id => &recordid )->pk();
column( name => &word )->unique();

table('photo');

column( photo_id => &recordid )->pk();
column( uploaded_at => &datetime('create') );

1;

