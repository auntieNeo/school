library ieee;
use ieee.std_logic_1164.all;

entity demux is
  port(i : in std_logic;
       s : in std_logic_vector;
       o0, o1, o2, o3, o4, o5, o6, o7 : out std_logic);
end demux;

architecture demux_architecture of demux is
begin
  o0 <= not s(2) and not s(1) and not s(0) and i;  -- 000
  o1 <= not s(2) and not s(1) and s(0) and i;      -- 001
  o2 <= not s(2) and s(1) and not s(0) and i;      -- 010
  o3 <= not s(2) and s(1) and s(0) and i;          -- 011
  o4 <= s(2) and not s(1) and not s(0) and i;      -- 100
  o5 <= s(2) and not s(1) and s(0) and i;          -- 101
  o6 <= s(2) and s(1) and not s(0) and i;          -- 110
  o7 <= s(2) and s(1) and s(0) and i;              -- 111
end demux_architecture;
