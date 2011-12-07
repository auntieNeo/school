library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity main is
  port(--sw : in std_logic_vector(7 downto 0);
       an : inout std_logic_vector(3 downto 0);
       sevSeg : out std_logic_vector(6 downto 0);
       --ld : out std_logic_vector(7 downto 0);
       clock : in std_logic);
end main;

architecture behavior of main is
  component counter_16bit
    port (b : inout std_logic_vector(15 downto 0);
          tc : out std_logic;
          clk : in std_logic;
          cen : in std_logic;
          rst : in std_logic);
  end component;
  component bin2hex
    port(bin : in std_logic_vector(3 downto 0);
         hex : out std_logic_vector(6 downto 0));
  end component;
  signal d0, d1, d2, d3 : std_logic_vector(6 downto 0);
  signal clkdiv : std_logic_vector(12 downto 0);
  signal clkdiv2 : std_logic_vector(19 downto 0);
  signal divided_clock : std_logic;
  signal counter : std_logic_vector(15 downto 0);
begin

  counter_0: counter_16bit port map (b => counter, clk => divided_clock, cen => '1', rst => '0');

  -- create and connect the hex encoder to the 7 segment display
  hex0: bin2hex port map (bin(0) => counter(0), bin(1) => counter(1), bin(2) => counter(2), bin(3) => counter(3), hex => d0);
  hex1: bin2hex port map (bin(0) => counter(4), bin(1) => counter(5), bin(2) => counter(6), bin(3) => counter(7), hex => d1);
  hex2: bin2hex port map (bin(0) => counter(8), bin(1) => counter(9), bin(2) => counter(10), bin(3) => counter(11), hex => d2);
  hex3: bin2hex port map (bin(0) => counter(12), bin(1) => counter(13), bin(2) => counter(14), bin(3) => counter(15), hex => d3);

  p: process(clock) is
  begin
    if (rising_edge(clock)) then
      if (clkdiv = "0000000000000") then
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
      clkdiv <= (clkdiv + "0000000000001");
      if (clkdiv > "1000000000000") then
        clkdiv <= "0000000000000";
      end if;
      -- clock divider for counters
      if(clkdiv2 < "01111010000100100000") then
        divided_clock <= '0';
      else
        divided_clock <= '1';
      end if;
      clkdiv2 <= (clkdiv2 + "00000000000000000001");
      if(clkdiv2 > "11110100001001000000") then
        clkdiv2 <= "00000000000000000000";
      end if;
    end if;
  end process;
end behavior;
