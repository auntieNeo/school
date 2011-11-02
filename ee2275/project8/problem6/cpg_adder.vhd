library ieee;
use ieee.std_logic_1164.all;

entity cpg_adder is
  port(cin : in std_logic;
       a, b : in std_logic_vector(7 downto 0);
       s : out std_logic_vector(7 downto 0);
       cout : out std_logic);
end cpg_adder;

architecture behavior of cpg_adder is

  component cla_bit_slice
    port(a, b, cin : in std_logic;
         s, g, p : out std_logic);
  end component;

  component carry_propagate_generate 
    port(cin : in std_logic;
         p, g : in std_logic_vector(7 downto 0);
         c : inout std_logic_vector(7 downto 0));
  end component;

  signal p, g, c : std_logic_vector(7 downto 0);

begin
  cbs0: cla_bit_slice port map (a => a(0), b => b(0), cin => cin, s => s(0), g => g(0), p => p(0));
  cbs1: cla_bit_slice port map (a => a(1), b => b(1), cin => c(0), s => s(1), g => g(1), p => p(1));
  cbs2: cla_bit_slice port map (a => a(2), b => b(2), cin => c(1), s => s(2), g => g(2), p => p(2));
  cbs3: cla_bit_slice port map (a => a(3), b => b(3), cin => c(2), s => s(3), g => g(3), p => p(3));
  cbs4: cla_bit_slice port map (a => a(4), b => b(4), cin => c(3), s => s(4), g => g(4), p => p(4));
  cbs5: cla_bit_slice port map (a => a(5), b => b(5), cin => c(4), s => s(5), g => g(5), p => p(5));
  cbs6: cla_bit_slice port map (a => a(6), b => b(6), cin => c(5), s => s(6), g => g(6), p => p(6));
  cbs7: cla_bit_slice port map (a => a(7), b => b(7), cin => c(6), s => s(7), g => g(7), p => p(7));
  cpg: carry_propagate_generate port map (cin => '0', p => p, g => g, c => c);
  cout <= '1';
end behavior;
