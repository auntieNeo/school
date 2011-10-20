library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplier is
  port(cin : in std_logic;
       a, b : in std_logic_vector(7 downto 0);
       p : out std_logic_vector(7 downto 0);
       cout : out std_logic);
end multiplier;

architecture behavior of multiplier is
  component cpg_adder
    port(cin : in std_logic;
         a, b : in std_logic_vector(7 downto 0);
         s : out std_logic_vector(7 downto 0);
         cout : out std_logic);
  end component;

  signal p0, p1, p2, p3, p4, p5, p6, p7 : std_logic_vector(7 downto 0);
  signal i0, i1, i2, i3, i4, i5 : std_logic_vector(7 downto 0);
begin
  p0 <= a and (b(0) & b(0) & b(0) & b(0) & b(0) & b(0) & b(0) & b(0)); -- I hate vhdl
  p1 <= std_logic_vector(unsigned(a and (b(1) & b(1) & b(1) & b(1) & b(1) & b(1) & b(1) & b(1))) sll 1);
  p2 <= std_logic_vector(unsigned(a and (b(2) & b(2) & b(2) & b(2) & b(2) & b(2) & b(2) & b(2))) sll 2);
  p3 <= std_logic_vector(unsigned(a and (b(3) & b(3) & b(3) & b(3) & b(3) & b(3) & b(3) & b(3))) sll 3);
  p4 <= std_logic_vector(unsigned(a and (b(4) & b(4) & b(4) & b(4) & b(4) & b(4) & b(4) & b(4))) sll 4);
  p5 <= std_logic_vector(unsigned(a and (b(5) & b(5) & b(5) & b(5) & b(5) & b(5) & b(5) & b(5))) sll 5);
  p6 <= std_logic_vector(unsigned(a and (b(6) & b(6) & b(6) & b(6) & b(6) & b(6) & b(6) & b(6))) sll 6);
  p7 <= std_logic_vector(unsigned(a and (b(7) & b(7) & b(7) & b(7) & b(7) & b(7) & b(7) & b(7))) sll 7);

  adder0: cpg_adder port map (cin => '0', a => p0, b => p1, s => i0);
  adder1: cpg_adder port map (cin => '0', a => i0, b => p2, s => i1);
  adder2: cpg_adder port map (cin => '0', a => i1, b => p3, s => i2);
  adder3: cpg_adder port map (cin => '0', a => i2, b => p4, s => i3);
  adder4: cpg_adder port map (cin => '0', a => i3, b => p5, s => i4);
  adder5: cpg_adder port map (cin => '0', a => i4, b => p6, s => i5);
  adder6: cpg_adder port map (cin => '0', a => i5, b => p7, s => p);
end behavior;
