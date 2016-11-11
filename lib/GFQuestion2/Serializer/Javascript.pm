package GFQuestion2::Serializer::Javascript;
use base qw(GFQuestion2::Serializer);

use strict;
use warnings;

sub hash_header            { '{ ' }
sub hash_footer            { ' }' }
sub hash_divider           { ', ' }
sub hash_key_value_divider { ': ' }
sub array_header           { '[ ' }
sub array_footer           { ' ]' }
sub array_divider          { ', ' }

sub encode_scalar {
  my $self = shift;
  my $scalar = shift;
  defined($scalar) || return 'undefined';
  $scalar =~ s/\\/\\\\/gs;
  $scalar =~ s/'/\\'/gs;
  return "'" . $scalar . "'";
}

1;

