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
column( session_id => &recordid )->fk('session');

table('photo_note');

column( photo_id => &recordid )->pk();
column( note => &text );

table('session');

column( session_id => &recordid )->pk();

table('session_guest');

column( session_id => &recordid )->fk('session')->pk();
column( guest_id => &recordid )->fk('guest')->pk();

table('category');

column( category_id => &recordid )->pk();
column( code => &varchar(16) )->unique();

table('language');

column( language_id => &recordid )->pk();
column( code => &varchar(8) )->unique();

table('translation');

column( translation_id => &recordid )->pk();
column( type => varchar(size => 11, default => 'unspecified') );
column( language_id => &recordid )->fk('language');
column( msgkey => &varchar(255) );
column( msgstr => &text );

1;
