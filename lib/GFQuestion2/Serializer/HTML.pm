package GFQuestion2::Serializer::HTML;
use base qw(GFQuestion2::Serializer);

use strict;
use warnings;

sub default_indent  { '' }
sub default_newline { '' }

sub hash_header         { '<dl>' }
sub hash_footer         { '</dl>' }
sub hash_key_header     { '<dt>' }
sub hash_key_footer     { '</dt>' }
sub hash_value_header   { '<dd>' }
sub hash_value_footer   { '</dd>' }
sub array_header        { '<ol>' }
sub array_footer        { '</ol>' }
sub array_value_header  { '<li>' }
sub array_value_footer  { '</li>' }

sub encode_scalar {
  my $self = shift;
  my $scalar = shift;
  return '' unless defined $scalar;
  $scalar =~ s/&/&amp;/gs;
  $scalar =~ s/"/&quot;/gs;
  $scalar =~ s/</&lt;/gs;
  $scalar =~ s/>/&gt;/gs;
  return $scalar;
}

1;

