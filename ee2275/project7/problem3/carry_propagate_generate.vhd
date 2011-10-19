library ieee;
use ieee.std_logic_1164.all;

entity carry_propagate_generate is
  port(cin : in std_logic;
       p, g : in std_logic_vector(7 downto 0);
       c : out std_logic_vector(7 downto 0));
end carry_propagate_generate;

architecture behavior of carry_propagate_generate is
begin
  c(0) <= (cin and p(0)) or g(0);
  c(1) <= (cin and p(0) and p(1)) or
          (g(0) and p(1)) or
          g(1);
  c(2) <= (cin and p(0) and p(1) and p(2)) or
          (g(0) and p(1) and p(2)) or
          (g(1) and p(2)) or
          g(2);
  c(3) <= (cin and p(0) and p(1) and p(2) and p(3)) or
          (g(0) and p(1) and p(2) and p(3)) or
          (g(1) and p(2) and p(3)) or
          (g(2) and p(3)) or
          g(3);
  c(4) <= (cin and p(0) and p(1) and p(2) and p(3) and p(4)) or
          (g(0) and p(1) and p(2) and p(3) and p(4)) or
          (g(1) and p(2) and p(3) and p(4)) or
          (g(2) and p(3) and p(4)) or
          (g(3) and p(4)) or
          g(4);
  c(5) <= (cin and p(0) and p(1) and p(2) and p(3) and p(4) and p(5)) or
          (g(0) and p(1) and p(2) and p(3) and p(4) and p(5)) or
          (g(1) and p(2) and p(3) and p(4) and p(5)) or
          (g(2) and p(3) and p(4) and p(5)) or
          (g(3) and p(4) and p(5)) or
          (g(4) and p(5)) or
          g(5);
  c(6) <= (cin and p(0) and p(1) and p(2) and p(3) and p(4) and p(5) and p(6)) or
          (g(0) and p(1) and p(2) and p(3) and p(4) and p(5) and p(6)) or
          (g(1) and p(2) and p(3) and p(4) and p(5) and p(6)) or
          (g(2) and p(3) and p(4) and p(5) and p(6)) or
          (g(3) and p(4) and p(5) and p(6)) or
          (g(4) and p(5) and p(6)) or
          (g(5) and p(6)) or
          g(6);
end behavior;
