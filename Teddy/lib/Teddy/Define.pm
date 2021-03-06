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
column( session_id => &recordid )->fk('session');
column( md5 => varchar(32) )->unique();
column( uploaded_at => &datetime('create') );

table('photo_note');

column( photo_id => &recordid )->pk();
column( note => &text );

table('session');

column( session_id => &recordid )->pk();
column( id => &varchar(length('5ff81b43fb27c59e21cdb0445a8663caed614e40')) )->unique();

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

