library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparator is
  port(a, b : in std_logic_vector(7 downto 0);
       gt, lt : inout std_logic;
       eq : out std_logic);
end comparator;

architecture behavior of comparator is
begin
  gt <= '1' when a > b else '0';
  lt <= '1' when a < b else '0';
  eq <= not gt and not lt;
end behavior;
