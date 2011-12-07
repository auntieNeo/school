library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity counter_4bit is
  port (b : inout std_logic_vector(3 downto 0);
        tc : out std_logic;
        clk : in std_logic;
        cen : in std_logic;
        rst : in std_logic);
end counter_4bit;

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity counter_4bit_logic is
  port (a : in std_logic_vector(3 downto 0);
        b : out std_logic_vector(3 downto 0));
end counter_4bit_logic;

architecture behavior of counter_4bit is
  component FDCE
    generic( INIT : bit :=  '0');
    port ( C   : in    std_logic; 
           CE  : in    std_logic; 
           CLR : in    std_logic; 
           D   : in    std_logic; 
           Q   : out   std_logic);
  end component;
  component counter_4bit_logic
   port (a : in std_logic_vector(3 downto 0);
         b : out std_logic_vector(3 downto 0));
  end component;
  signal logic_to_ff : std_logic_vector(3 downto 0);
begin
  logic : counter_4bit_logic port map (a => b, b => logic_to_ff);
  flip_flop_0 : FDCE port map (C => clk, CE => cen, CLR => rst, D => logic_to_ff(0), Q => b(0));
  flip_flop_1 : FDCE port map (C => clk, CE => cen, CLR => rst, D => logic_to_ff(1), Q => b(1));
  flip_flop_2 : FDCE port map (C => clk, CE => cen, CLR => rst, D => logic_to_ff(2), Q => b(2));
  flip_flop_3 : FDCE port map (C => clk, CE => cen, CLR => rst, D => logic_to_ff(3), Q => b(3));
  tc <= b(0) and b(1) and b(2) and b(3);
end behavior;

architecture behavior of counter_4bit_logic is
begin
  with a select
  b <= "0001" when "0000",
       "0010" when "0001",
       "0011" when "0010",
       "0100" when "0011",
       "0101" when "0100",
       "0110" when "0101",
       "0111" when "0110",
       "1000" when "0111",
       "1001" when "1000",
       "1010" when "1001",
       "1011" when "1010",
       "1100" when "1011",
       "1101" when "1100",
       "1110" when "1101",
       "1111" when "1110",
       "0000" when others;
end behavior;

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity counter_16bit is
  port (b : inout std_logic_vector(15 downto 0);
        tc : out std_logic;
        clk : in std_logic;
        cen : in std_logic;
        rst : in std_logic);
end counter_16bit;

architecture behavior of counter_16bit is
  component counter_4bit
    port (b : inout std_logic_vector(3 downto 0);
          tc : out std_logic;
          clk : in std_logic;
          cen : in std_logic;
          rst : in std_logic);
  end component;
  component FDCE
    generic( INIT : bit :=  '0');
    port ( C   : in    std_logic; 
           CE  : in    std_logic; 
           CLR : in    std_logic; 
           D   : in    std_logic; 
           Q   : out   std_logic);
  end component;
  signal tc0, tc1, tc2, tc3 : std_logic;
  signal c1_clk, c2_clk, c3_clk : std_logic;
begin
  flip_flop_tc0 : FDCE port map (C => clk, CE => cen, CLR => rst, D => tc0, Q => c1_clk);
  flip_flop_tc1 : FDCE port map (C => clk, CE => cen, CLR => rst, D => tc1, Q => c2_clk);
  flip_flop_tc2 : FDCE port map (C => clk, CE => cen, CLR => rst, D => tc2, Q => c3_clk);
  counter_0 : counter_4bit port map (b(0) => b(0), b(1) => b(1), b(2) => b(2), b(3) => b(3), tc => tc0, clk => clk, cen => cen, rst => rst);
  counter_1 : counter_4bit port map (b(0) => b(4), b(1) => b(5), b(2) => b(6), b(3) => b(7), tc => tc1, clk => c1_clk, cen => cen, rst => rst);
  counter_2 : counter_4bit port map (b(0) => b(8), b(1) => b(9), b(2) => b(10), b(3) => b(11), tc => tc2, clk => c2_clk, cen => cen, rst => rst);
  counter_3 : counter_4bit port map (b(0) => b(12), b(1) => b(13), b(2) => b(14), b(3) => b(15), tc => tc3, clk => c3_clk, cen => cen, rst => rst);
  tc <= tc0 and tc1 and tc2 and tc3;
end behavior;
