package GFQuestion2::Serializer::Perl;
use base qw(GFQuestion2::Serializer);

use strict;
use warnings;

sub default_indent  { '' }
sub default_newline { '' }

sub hash_header            { '{' . $_[0]->newline . $_[0]->indent x $_[1] }
sub hash_footer            { $_[0]->newline . '}' }
sub hash_divider           { ',' . $_[0]->newline . $_[0]->indent x $_[1] }
sub hash_key_value_divider { ' => ' }
sub hash_entry_divider     { ',' . $_[0]->newline . $_[0]->indent x $_[1] }
sub array_header           { '[' . $_[0]->newline . $_[0]->indent x $_[1] }
sub array_footer           { $_[0]->newline . ']' }
sub array_divider          { ',' . $_[0]->newline . $_[0]->indent x $_[1] }
sub array_value_divider    { ',' . $_[0]->newline  }

sub encode_scalar {
  my $self = shift;
  my $scalar = shift;
  defined($scalar) || return 'undef';
  $scalar =~ s/\\/\\\\/gs;
  $scalar =~ s/'/\\'/gs;
  return "'" . $scalar . "'";
}

1;
