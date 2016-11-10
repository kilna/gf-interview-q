package GFQuestion2::Serializer::HTML;
use base qw(GFQuestion2::Serializer);

use strict;
use warnings;

sub default_indent  { '' }
sub default_newline { '' }

sub hash_header        { $_[0]->indent($_[1]) . '<dl>' . $_[0]->newline }
sub hash_footer        { $_[0]->indent($_[1]) . '</dl>' . $_[0]->newline }
sub hash_key_header    { $_[0]->indent($_[1]+1) . '<dt>' }
sub hash_key_footer    { '</dt>' }
sub hash_value_header  { $_[0]->indent($_[1]) . '<dd>' . ( $_[2] ? $_[0]->newline : '' ) }
sub hash_value_footer  { ( $_[0]->newline . $_[0]->indent($_[1]) : '' ) . '</dd>' . $_[0]->newline }
sub array_header       { $_[0]->indent($_[1]+1) . '<ol>' . $_[0]->newline }
sub array_footer       { $_[0]->indent($_[1]+1) . '</ol>' . $_[0]->newline }
sub array_value_header { $_[0]->indent($_[1]+2) . '<li>' . ( $_[2] ? $_[0]->newline : '' ) }
sub array_value_footer { '</li>' . $_[0]->newline }

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
