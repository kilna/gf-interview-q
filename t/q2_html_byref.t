#!/bin/env perl

use strict;
use warnings;
use Test::More 'tests' => 9;
use FindBin;
require "$FindBin::Bin/structs.pl";

BEGIN { use_ok('GFQuestion2::Serializer'); }

# This series of tests checks that the GFQuestion2::Serializer::new('HTML') syntax for creating an object works
# just as well as calling it as GFQuestion2::Serializer::HTML->new(). This way the type of serializaton can be
# specified using a single instantiator (this is to meet the requirement that there be a single calling syntax).
my $serializer = eval { GFQuestion2::Serializer::new('HTML') };
is( $@, '', 'Eval during GFQuestion2::Serializer::new()' );
isa_ok( $serializer, 'GFQuestion2::Serializer::HTML' );

my $out = eval { $serializer->serialize( hash_struct() ) };
is( $@, '', "Hash serialize evaluated without error" );
is(
  $out,
  '<dl><dt>email</dt><dd>kilna@kilna.com</dd><dt>favorite_numbers</dt><dd><ol><li>2</li><li>4</li><li>7</li><li>8</li><li>13</li><li>16</li><li>32</li><li>42</li><li>64</li><li>128</li><li>256</li></ol></dd><dt>hash</dt><dd><dl><dt>foo</dt><dd>bar</dd></dl></dd><dt>missing</dt><dd></dd><dt>name</dt><dd>kilna</dd></dl>',
  'Serialized hash HTML matches expected output'
);

$out = eval { $serializer->serialize( array_struct() ) };
is( $@, '', "Array serialize evaluated without error" );
is(
  $out,
  '<ol><li><dl><dt>id</dt><dd>item1</dd></dl></li><li><dl><dt>id</dt><dd>item2</dd></dl></li></ol>',
  'Serialized array HTML matches expected output'
);

$out = eval { $serializer->serialize( 'foo>bar' ) };
is( $@, '', "Scalar serialize evaluated without error" );
is(
  $out,
  'foo&gt;bar',
  'Serialized scalar HTML matches expected output'
);


