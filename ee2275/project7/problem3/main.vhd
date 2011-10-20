library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity main is
  port(sw : in std_logic_vector(7 downto 0);
       an : inout std_logic_vector(3 downto 0);
       sevSeg : out std_logic_vector(6 downto 0);
       clock : in std_logic);
end main;

architecture behavior of main is

component cpg_adder
  port(cin : in std_logic;
       a, b : in std_logic_vector(7 downto 0);
       s : out std_logic_vector(7 downto 0);
       cout : out std_logic);
end component;

component multiplier
  port(cin : in std_logic;
       a, b : in std_logic_vector(7 downto 0);
       p : out std_logic_vector(7 downto 0);
       cout : out std_logic);
end component;

component bin2hex
  port(bin : in std_logic_vector(3 downto 0);
       hex : out std_logic_vector(6 downto 0));
end component;

signal sum : std_logic_vector(7 downto 0);
alias sum0 : std_logic_vector(3 downto 0) is sum(3 downto 0);
signal prod : std_logic_vector(7 downto 0);
alias prod0 : std_logic_vector(3 downto 0) is prod(3 downto 0);
signal d0, d1, d2, d3 : std_logic_vector(6 downto 0);
signal counter : std_logic_vector(12 downto 0);
begin

  adder: cpg_adder port map (cin => '0', a(0) => sw(0), a(1) => sw(1), a(2) => sw(2), a(3) => sw(3), a(4) => '0', a(5) => '0', a(6) => '0', a(7) => '0', b(0) => sw(4), b(1) => sw(5), b(2) => sw(6), b(3) => sw(7), b(4) => '0', b(5) => '0', b(6) => '0', b(7) => '0', s => sum);
  multi: multiplier port map (cin => '0', a(0) => sw(0), a(1) => sw(1), a(2) => sw(2), a(3) => sw(3), a(4) => '0', a(5) => '0', a(6) => '0', a(7) => '0', b(0) => sw(4), b(1) => sw(5), b(2) => sw(6), b(3) => sw(7), b(4) => '0', b(5) => '0', b(6) => '0', b(7) => '0', p => prod);

  hex0: bin2hex port map (bin => sum0, hex => d0);
  hex1: bin2hex port map (bin(0) => sum(4), bin(1) => sum(5), bin(2) => sum(6), bin(3) => sum(7), hex => d1);
  hex2: bin2hex port map (bin => prod0, hex => d2);
  hex3: bin2hex port map (bin(0) => prod(4), bin(1) => prod(5), bin(2) => prod(6), bin(3) => prod(7), hex => d3);

  p: process(clock) is
  begin
    if (rising_edge(clock)) then
      if (counter = "0000000000000") then
        if (an(0) = '0') then
          an <= "1101";
          sevSeg <= d1;
        elsif (an(1) = '0') then
          an <= "1011";
          sevSeg <= d2;
        elsif (an(2) = '0') then
          an <= "0111";
          sevSeg <= d3;
        elsif (an(3) = '0') then
          an <= "1110";
          sevSeg <= d0;
        end if;
      end if;
      counter <= (counter + "0000000000001");
      if (counter > "1000000000000") then
        counter <= "0000000000000";
      end if;
    end if;
  end process;
end behavior;
