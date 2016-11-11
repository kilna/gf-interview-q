#!/bin/env perl

use strict;
use warnings;
use Test::More 'tests' => 11;
use FindBin;
require "$FindBin::Bin/structs.pl";

BEGIN { use_ok('GFQuestion2::Serializer::Perl'); }

my $enc = eval { GFQuestion2::Serializer::Perl->new() };
is( $@, '', 'Eval during GFQuestion2::Serializer::Perl->new()' );
isa_ok( $enc, 'GFQuestion2::Serializer::Perl' );

my $out = eval { $enc->serialize( hash_struct() ) };
is( $@, '', "Hash serialize evaluated without error" );
is(
  $out,
  q|{ 'email' => 'kilna@kilna.com', 'favorite_numbers' => [ '2', '4', '7', '8', '13', '16', '32', '42', '64', '128', '256' ], 'hash' => { 'foo' => 'bar' }, 'missing' => undef, 'name' => 'kilna' }|,
  'Serialized hash Perl matches expected output'
);
my $deserialized;
eval "\$deserialized = $out"; 
is( $@, '', "Hash deserialized without error" );
is_deeply(
  hash_struct(),
  $deserialized,
  'Deserialized variable matched expected structure'
);

$out = eval { $enc->serialize( array_struct() ) };
is( $@, '', "Array serialize evaluated without error" );
is(
  $out,
  q|[ { 'id' => 'item1' }, { 'id' => 'item2' } ]|,
  'Serialized array Perl matches expected output'
);

$out = eval { $enc->serialize( q('foo' is "bar") ) };
is( $@, '', "Scalar serialize evaluated without error" );
is(
  $out,
  q('\\'foo\\' is "bar"'),
  'Serialized scalar Perl matches expected output'
);

