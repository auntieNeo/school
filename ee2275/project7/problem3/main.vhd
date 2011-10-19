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
signal d0, d1, d2, d3 : std_logic_vector(6 downto 0);
signal counter : std_logic_vector(12 downto 0);
begin
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
  d0 <= "1100000";
  d1 <= "1100010";
  d2 <= "1100010";
  d3 <= "1100000";
end behavior;
