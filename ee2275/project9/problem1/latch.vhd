library ieee;
use ieee.std_logic_1164.all;

entity nand_gate is
  port(a, b : in std_logic;
       y : out std_logic);
end nand_gate;

architecture behavior of nand_gate is
begin
  y <= a nand b after 1 ns;
end behavior;

library ieee;
use ieee.std_logic_1164.all;

entity latch is
  port(s, r : in std_logic;
       q, qn : out std_logic);
end latch;

architecture behavior of latch is
  component nand_gate
    port(a, b : in std_logic;
         y : out std_logic);
  end component;
  signal int1 : std_logic := '0';
  signal int2 : std_logic := '0';
begin
  NG1: nand_gate port map (a => s, b => int2, y => int1);
  NG2: nand_gate port map (a => int1, b => r, y => int2);
  q <= int2;
  qn <= int1;
end behavior;
