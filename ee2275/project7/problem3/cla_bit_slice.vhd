library ieee;
use ieee.std_logic_1164.all;

entity cla_bit_slice is
  port(a, b, cin : in std_logic;
       s, g, p : out std_logic);
end cla_bit_slice;

architecture behavior of cla_bit_slice is
begin
  s <= (not a and not b and cin) or (not a and b and not cin) or (a and not b and not cin) or (a and b and cin);
  g <= a and b;
  p <= (a and not b) or (not a and b);  -- FIXME: isn't this just xor?
end behavior;
