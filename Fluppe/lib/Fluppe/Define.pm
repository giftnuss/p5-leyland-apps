  package Fluppe::Define;
# ***********************
  our $VERSION = '0.01';
# **********************
use strict; use warnings; use utf8;

use DBIx::Define table => undef;

table('project');

column(project_id => &recordid)->pk();
column(name => &word)->unique();

1;

