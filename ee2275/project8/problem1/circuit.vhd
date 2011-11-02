library ieee;
use ieee.std_logic_1164.all;

entity circuit is
  port(a, b, c : in std_logic;
       y : out std_logic);
end circuit;

architecture behavior of circuit is
signal int0, int1, int2, int3 : std_logic;
begin
  int0 <= not a after 1ns;
  int1 <= int0 and b after 1ns;
  int2 <= a and c after 1ns;
  int3 <= b and c after 1ns;
  y <= int1 or int2 or int3 after 1ns;
end behavior;
