sub hash_struct {
  return {
    'name'  => 'kilna',
    'email' => 'kilna@kilna.com',
    'favorite_numbers' => [ 2, 4, 7, 8, 13, 16, 32, 42, 64, 128, 256 ],
    'hash' => {
      'foo' => 'bar',
    },
    'missing' => undef,
  };
}

sub array_struct {
  return [
    { 'id' => 'item1' },
    { 'id' => 'item2' },
  ];
}

1;
