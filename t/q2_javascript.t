#!/bin/env perl

use strict;
use warnings;
use Test::More 'tests' => 9;
use FindBin;
require "$FindBin::Bin/structs.pl";

BEGIN { use_ok('GFQuestion2::Serializer::Javascript'); }

my $enc = eval { GFQuestion2::Serializer::Javascript->new() };
is( $@, '', 'Eval during GFQuestion2::Serializer::Javascript->new()' );
isa_ok( $enc, 'GFQuestion2::Serializer::Javascript' );

my $out = eval { $enc->serialize( hash_struct() ) };
is( $@, '', "Hash serialize evaluated without error" );
is(
  $out,
  q<{ 'email': 'kilna@kilna.com', 'favorite_numbers': [ '2', '4', '7', '8', '13', '16', '32', '42', '64', '128', '256' ], 'hash': { 'foo': 'bar' }, 'missing': undefined, 'name': 'kilna' }>,
  'Serialized hash Javascript matches expected output'
);

$out = eval { $enc->serialize( array_struct() ) };
is( $@, '', "Array serialize evaluated without error" );
is(
  $out,
  q<[ { 'id': 'item1' }, { 'id': 'item2' } ]>,
  'Serialized array Javascript matches expected output'
);

$out = eval { $enc->serialize( q('foo' is "bar") ) };
is( $@, '', "Scalar serialize evaluated without error" );
is(
  $out,
  q('\\'foo\\' is "bar"'),
  'Serialized scalar Javascript matches expected output'
);


