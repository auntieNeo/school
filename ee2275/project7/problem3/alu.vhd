library ieee;
use ieee.std_logic_1164.all;

entity alu is
  port(a, b : in std_logic_vector(7 downto 0);
       f : out std_logic_vector(7 downto 0);
       cin : in std_logic;
       cout : out std_logic;
       sel : in std_logic_vector(2 downto 0));
end alu;

library ieee;
use ieee.std_logic_1164.all;

entity alu_demux is
  port(i : in std_logic_vector(7 downto 0);
       o0, o1, o2, o3, o4, o5, o6, o7 : out std_logic_vector(7 downto 0);
       s : in std_logic_vector(2 downto 0));
end alu_demux;

library ieee;
use ieee.std_logic_1164.all;

entity alu_mux is
  port(i0, i1, i2, i3, i4, i5, i6, i7 : in std_logic_vector(7 downto 0);
       o : out std_logic_vector(7 downto 0);
       s : in std_logic_vector(2 downto 0));
end alu_mux;

architecture behavior of alu is
  component alu_demux
    port(i : in std_logic_vector(7 downto 0);
         o0, o1, o2, o3, o4, o5, o6, o7 : out std_logic_vector(7 downto 0);
         s : in std_logic_vector(2 downto 0));
  end component;

  component alu_mux
    port(i0, i1, i2, i3, i4, i5, i6, i7 : in std_logic_vector(7 downto 0);
         o : out std_logic_vector(7 downto 0);
         s : in std_logic_vector(2 downto 0));
  end component;

  component cpg_adder
    port(cin : in std_logic;
         a, b : in std_logic_vector(7 downto 0);
         s : out std_logic_vector(7 downto 0);
         cout : out std_logic);
  end component;

  signal demux_add_a, demux_add_b, mux_add : std_logic_vector(7 downto 0);
begin
  dm_a : alu_demux port map (i => a, o0 => demux_add_a, s => sel);
  dm_b : alu_demux port map (i => b, o0 => demux_add_b, s => sel);

  -- connect the adder
  adder : cpg_adder port map (cin => '0', a => demux_add_a, b => demux_add_b, s => mux_add);

  m : alu_mux port map(i0 => mux_add, i1 => mux_add, i2 => mux_add, i3 => mux_add, i4 => mux_add, i5 => mux_add, i6 => mux_add, i7 => mux_add, o => f, s => sel);
end behavior;

architecture behavior of alu_demux is
  component demux
    port(i : in std_logic;
         o0, o1, o2, o3, o4, o5, o6, o7 : out std_logic;
         s : in std_logic_vector);
  end component;
begin
  dm0 : demux port map (i => i(0), o0 => o0(0), o1 => o1(0), o2 => o2(0), o3 => o3(0), o4 => o4(0), o5 => o5(0), o6 => o6(0), o7 => o7(0), s => s);
  dm1 : demux port map (i => i(1), o0 => o0(1), o1 => o1(1), o2 => o2(1), o3 => o3(1), o4 => o4(1), o5 => o5(1), o6 => o6(1), o7 => o7(1), s => s);
  dm2 : demux port map (i => i(2), o0 => o0(2), o1 => o1(2), o2 => o2(2), o3 => o3(2), o4 => o4(2), o5 => o5(2), o6 => o6(2), o7 => o7(2), s => s);
  dm3 : demux port map (i => i(3), o0 => o0(3), o1 => o1(3), o2 => o2(3), o3 => o3(3), o4 => o4(3), o5 => o5(3), o6 => o6(3), o7 => o7(3), s => s);
  dm4 : demux port map (i => i(4), o0 => o0(4), o1 => o1(4), o2 => o2(4), o3 => o3(4), o4 => o4(4), o5 => o5(4), o6 => o6(4), o7 => o7(4), s => s);
  dm5 : demux port map (i => i(5), o0 => o0(5), o1 => o1(5), o2 => o2(5), o3 => o3(5), o4 => o4(5), o5 => o5(5), o6 => o6(5), o7 => o7(5), s => s);
  dm6 : demux port map (i => i(6), o0 => o0(6), o1 => o1(6), o2 => o2(6), o3 => o3(6), o4 => o4(6), o5 => o5(6), o6 => o6(6), o7 => o7(6), s => s);
  dm7 : demux port map (i => i(7), o0 => o0(7), o1 => o1(7), o2 => o2(7), o3 => o3(7), o4 => o4(7), o5 => o5(7), o6 => o6(7), o7 => o7(7), s => s);
end behavior;

architecture behavior of alu_mux is
  component mux
    port(i0, i1, i2, i3, i4, i5, i6, i7 : in std_logic;
         o : out std_logic;
         s : in std_logic_vector(2 downto 0));
  end component;
begin
  m0 : mux port map (i0 => i0(0), i1 => i1(0), i2 => i2(0), i3 => i3(0), i4 => i4(0), i5 => i5(0), i6 => i6(0), i7 => i7(0), o => o(0), s => s);
  m1 : mux port map (i0 => i0(1), i1 => i1(1), i2 => i2(1), i3 => i3(1), i4 => i4(1), i5 => i5(1), i6 => i6(1), i7 => i7(1), o => o(1), s => s);
  m2 : mux port map (i0 => i0(2), i1 => i1(2), i2 => i2(2), i3 => i3(2), i4 => i4(2), i5 => i5(2), i6 => i6(2), i7 => i7(2), o => o(2), s => s);
  m3 : mux port map (i0 => i0(3), i1 => i1(3), i2 => i2(3), i3 => i3(3), i4 => i4(3), i5 => i5(3), i6 => i6(3), i7 => i7(3), o => o(3), s => s);
  m4 : mux port map (i0 => i0(4), i1 => i1(4), i2 => i2(4), i3 => i3(4), i4 => i4(4), i5 => i5(4), i6 => i6(4), i7 => i7(4), o => o(4), s => s);
  m5 : mux port map (i0 => i0(5), i1 => i1(5), i2 => i2(5), i3 => i3(5), i4 => i4(5), i5 => i5(5), i6 => i6(5), i7 => i7(5), o => o(5), s => s);
  m6 : mux port map (i0 => i0(6), i1 => i1(6), i2 => i2(6), i3 => i3(6), i4 => i4(6), i5 => i5(6), i6 => i6(6), i7 => i7(6), o => o(6), s => s);
  m7 : mux port map (i0 => i0(7), i1 => i1(7), i2 => i2(7), i3 => i3(7), i4 => i4(7), i5 => i5(7), i6 => i6(7), i7 => i7(7), o => o(7), s => s);
end behavior;
