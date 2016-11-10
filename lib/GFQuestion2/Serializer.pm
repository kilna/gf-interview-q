package GFQuestion2::Serializer;

use strict;
use warnings;
use Carp qw(croak);

sub new {
  my $class = shift;
  no strict 'refs'; # Don't barf on the line below when we peek a the symbol table
  require $class unless scalar keys %{$class.'::'}; # Load the module if it isn't already
  my $self = { @_ };
  bless $self, $class;
}

# These should be overridden by subclasses, the default for all is blank
# They all have the same input 3 input parameters
# $_[0] / $self - the encoder object
# $_[1] / $level (optional, should default to 0) - an integer of how deeply nested the item in question is
# $_[2] / $has_children (optional, should default to 0) - whether this structure has children - Not relevant for hash keys
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

# Default scalar encoder is to just return the string verbatim
sub encode_scalar { croak __PACKAGE__.'->encode_scalar must be overridden in a subclass' }

sub encode {
  my $self   = shift;
  my $struct = shift;
  my $level = defined( $_[0] ) ? shift(@_) : 0; # number of indents
  if ( not defined $struct ) {
    return $self->encode_scalar($struct);
  }
  my $reftype = ref $struct;
  if ( $reftype eq 'HASH' ) {
    return $self->hash_header( $level ) . (
      join $self->hash_divider( $level ), map {
        my $has_children = ( ref $struct->{$_} ne '' );
        $self->hash_key_header( $level )
          . $self->encode_scalar( $_ )
          . $self->hash_key_footer( $level ) 
          . $self->hash_key_value_divider( $level, $has_children )
          . $self->hash_value_header( $level, $has_children )
          . $self->encode( $struct->{$_}, $level+1, $has_children )
          . $self->hash_value_footer( $level, $has_children );
      } keys %$struct
    ) . $self->hash_footer( $level );
  }
  elsif ( $reftype eq 'ARRAY' ) {
    return $self->array_header( $level ) . (
      join $self->array_divider( $level ), map {
        my $has_children = ( ref $_ ne '' );
        $self->array_value_header( $level, $has_children)
          . $self->encode( $_, $level+1, $has_children )
          . $self->array_value_footer( $level, $has_children )
      } @$struct
    ) . $self->array_footer( $level );
  }
  elsif ( $reftype ne '' ) {
    croak "Unhandled reference type $reftype";
  }
  else {
    return $self->encode_scalar($struct);
  }
}

sub indent {
  my $self = shift;
  my $level = defined($_[0]) ? shift(@_) : 1;
  defined($self->{indent}) && return $self->{indent} x $level;
  defined(ref($self)->default_indent) && return ref($self)->default_indent x $level;
  return "\t" x $level;
}

sub newline {
  my $self = shift;
  my $level = defined($_[0]) ? shift(@_) : 1;
  defined($self->{newline}) && return $self->{newline} x $level;
  defined(ref($self)->default_newline) && return ref($self)->default_newline x $level;
  return "\n" x $level;
}

1;
