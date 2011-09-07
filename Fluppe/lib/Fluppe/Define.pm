  package Fluppe::Define;
# ***********************
  our $VERSION = '0.01';
# **********************
use strict; use warnings; use utf8;

use DBIx::Define table => undef;

############################
#        ACCESSORS         #
############################
sub schema {
  return DBIx::Define->get_schema('fluppe');
}

sub translator {
  return DBIx::Define->translate('fluppe');
}

sub sql_for {
  my ($self,$producer) = @_;
  my $translator = DBIx::Define->translate('fluppe'); 
  return $translator->producer($producer)->($translator);
}
############################
#      DATABASE SCHEMA     #
############################
table('project');

column( project_id => &recordid )->pk();
column( name => &word )->unique();

table('repository');

column( repository_id => &recordid )->pk();
#column( url => &url )->unique();
column( url => &word )->unique();

table('project_repository');

column( project_id => &recordid )->fk('project');
column( repository_id => &recordid )->fk('repository');

1;

