library ieee;
use ieee.std_logic_1164.all;

entity mux is
  port(i0, i1, i2, i3, i4, i5, i6, i7 : in std_logic;
       o : out std_logic;
       s : in std_logic_vector(2 downto 0));
end mux;

architecture mux_architecture of mux is
begin
  o <= (not s(2) and not s(1) and not s(0) and i0) or  -- 000
       (not s(2) and not s(1) and s(0) and i1) or      -- 001
       (not s(2) and s(1) and not s(0) and i2) or      -- 010
       (not s(2) and s(1) and s(0) and i3) or          -- 011
       (s(2) and not s(1) and not s(0) and i4) or      -- 100
       (s(2) and not s(1) and s(0) and i5) or          -- 101
       (s(2) and s(1) and not s(0) and i6) or          -- 110
       (s(2) and s(1) and s(0) and i7);                -- 111
end mux_architecture;
