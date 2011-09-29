library ieee;
use ieee.std_logic_1164.all;

entity main is
  port(b0, b1, b2, b3 : in std_logic;
       s : in std_logic_vector(2 downto 0);
       l0, l1, l2, l3, l4, l5, l6, l7 : out std_logic);
end main;

architecture main_architecture of main is

component mux
  port(i0, i1, i2, i3, i4, i5, i6, i7 : in std_logic;
       s : in std_logic_vector(2 downto 0);
       o : out std_logic);
end component;

component demux
  port(i : in std_logic;
       s : in std_logic_vector(2 downto 0);
       o0, o1, o2, o3, o4, o5, o6, o7 : out std_logic);
end component;

signal intmux : std_logic;
signal b4, b5, b6, b7 : std_logic;

begin
b4 <= b0 and b1;
b5 <= b1 and b2;
b6 <= b2 and b3;
b7 <= b3 and b0;
M: mux port map (i0=>b0, i1=>b1, i2=>b2, i3=>b3, i4=>b4, i5=>b5, i6=>b6, i7=>b7, s=>s, o=>intmux);
DM: demux port map (i=>intmux, s=>s, o0=>l0, o1=>l1, o2=>l2, o3=>l3, o4=>l4, o5=>l5, o6=>l6, o7=>l7);

end main_architecture;
