library ieee;
use ieee.std_logic_1164.all;

entity circuit is
  port(a, b, c, d, e, f: in std_logic;
       y : out std_logic);
end circuit;

architecture circuit_architecture of circuit is
begin
  y <= (not a and not b and not c and d) or 
       (not a and not b and c and (d or e)) or
       (not a and b and not c and (e xnor f)) or
       (not a and b and c and (e xor f)) or
       (a and not b and not c and (not d)) or
       (a and not b and c and (d nand e)) or
       (a and b and c);
end circuit_architecture;
