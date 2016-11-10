#!/bin/env perl

use strict;
use warnings;

use Test::More 'tests' => 999;

BEGIN { use_ok('GFQuestion2::Serializer::HTML'); }

my $enc = eval { GFQuestion2::Serializer::HTML->new( 'newline' => "\n", 'indent' => "  " ) };
is( $@, '', 'Eval during GFQuestion2::Serializer::HTML->new()' );
isa_ok( $enc, 'GFQuestion2::Serializer::HTML' );

my $hash_struct = {
  'name'  => 'kilna',
  'email' => 'kilna@kilna.com',
  'favorite_numbers' => [ 2, 4, 7, 8, 13, 16, 32, 42, 64, 128, 256 ],
  'hash' => {
    'foo' => 'bar',
  },
};
my $out = $enc->encode($hash_struct);
print $out;

