package GFQuestion2::Serializer;
my $pkg = __PACKAGE__;

use strict;
use warnings;
use Carp qw(croak);

sub new {
  my $class = shift;
  # Resolve HTML -> GFQuestion2::Serializer::HTML
  if ($class !~ m/^\Q${pkg}\E::/) { $class = "${pkg}::$class" } 
  no strict 'refs'; # Don't barf on the line below when we peek a the symbol table
  # Load the module at runtime if it isn't loaded already
  unless ( scalar keys %{$class.'::'} ) { eval "use $class" }
  bless { @_ }, $class;
}

# These methods should be overridden by subclasses, the default for all is blank
sub hash_header            { '' }
sub hash_footer            { '' }
sub hash_divider           { '' }
sub hash_key_header        { '' }
sub hash_key_footer        { '' }
sub hash_key_value_divider { '' }
sub hash_value_header      { '' }
sub hash_value_footer      { '' }
sub array_header           { '' }
sub array_footer           { '' }
sub array_divider          { '' }
sub array_value_header     { '' }
sub array_value_footer     { '' }

sub encode_scalar {
  croak $pkg.'->encode_scalar must be overridden in a subclass';
}

sub serialize {
  my $self   = shift;
  my $struct = shift;
  defined($struct) || return $self->encode_scalar($struct);
  if ( ref($struct) eq 'HASH' ) {
    return $self->hash_header . (
      join $self->hash_divider, map {
        $self->hash_key_header . $self->encode_scalar( $_ )
          . $self->hash_key_footer . $self->hash_key_value_divider
          . $self->hash_value_header . $self->serialize( $struct->{$_} )
          . $self->hash_value_footer
      } sort keys %$struct
    ) . $self->hash_footer;
  }
  elsif ( ref($struct) eq 'ARRAY' ) {
    return $self->array_header . (
      join $self->array_divider, map {
        $self->array_value_header . $self->serialize( $_ )
          . $self->array_value_footer
      } @$struct
    ) . $self->array_footer;
  }
  elsif ( ref($struct) ne '' ) {
    croak "Unhandled reference type ".ref($struct);
  }
  else {
    return $self->encode_scalar($struct);
  }
}

1;

