LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
    COMPONENT circuit
      port(a, b, c : in std_logic;
           y : out std_logic);
    END COMPONENT;

   --Inputs
   signal a : std_logic := '0';
   signal b : std_logic := '0';
   signal c : std_logic := '0';

 	--Outputs
   signal y : std_logic;
 
   constant period : time := 10 ns;

function to_logic (I: integer) return std_logic is
begin
  if I = 0 then
    return '0';
  else
    return '1';
  end if;
end function to_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: circuit PORT MAP (
          a => a,
          b => b,
          c => c,
          y => y
        );

   -- Stimulus process
   stim_proc: process
   begin
    a <= '1';
    b <= '1';
    c <= '1';
    wait for period;
    a <= '0';
    wait for period;
    a <= '1';
    wait for period;
    a <= '0';
    b <= '0';
    c <= '0';
    wait for period;
    a <= '1';
    wait for period;
    a <= '0';
    wait for period;
--    for I in 0 to 1 loop
--      for J in 0 to 1 loop
--        for K in 0 to 1 loop
--          a <= to_logic(I);
--          b <= to_logic(J);
--          c <= to_logic(K);
--          wait for period;
--        end loop;
--      end loop;
--    end loop;
   end process;

END;
