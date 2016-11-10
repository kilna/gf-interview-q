#!/bin/env perl

use strict;
use warnings;

use Test::More 'tests' => 8;

BEGIN { use_ok('GFQuestion1', 'process_array_of_characters') }

my @test_cases = (
  # Input, Output, Name
  [ 'Cat',  'tAc',  'Simple use case'   ],
  [ 'foo!', '!OOf', 'Punctuation works' ],
  [ '1234', '4321', 'Numbers work'      ],
);

foreach my $test_case (@test_cases) {
  my @input           = ( split //, $test_case->[0] );
  my @expected_output = ( split //, $test_case->[1] );
  my $test_name = $test_case->[2];
  my @output = eval { process_array_of_characters @input };
  is( $@, '', "$test_name - evaluate"); 
  is_deeply( \@output, \@expected_output, "$test_name - compare output")
}

eval { process_array_of_characters 'die!' };
isnt( $@, '', 'Error thrown when providing non-single-character input');

