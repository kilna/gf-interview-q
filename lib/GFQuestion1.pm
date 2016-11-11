package GFQuestion1;
require Exporter;
@ISA = qw(Exporter);
@EXPORT_OK = qw(process_array_of_characters);

use strict;
use warnings;

our $VERSION='1.0.0';

sub process_array_of_characters (@) {
  return reverse map {
    (length == 1) or die "process_array_of_strings can only process an array of characters";
    tr/aBCDeFGHiJKLMNoPQRSTuVWXYZ/AbcdEfghIjklmnOpqrstUvwxyz/;
    $_;
  } @_;
}

1;
