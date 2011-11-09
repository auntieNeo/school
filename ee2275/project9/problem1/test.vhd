LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
    COMPONENT latch
      port(s, r : in std_logic;
           q, qn : out std_logic);
    END COMPONENT;

   --Inputs
   signal s : std_logic := '0';
   signal r : std_logic := '0';

 	--Outputs
   signal q : std_logic;
   signal qn : std_logic;
 
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
   uut: latch PORT MAP (
        s => s, r => r, q => q, qn => qn
        );

   -- Stimulus process
   stim_proc: process
   begin
     wait for 100 ns;
     s <= '1';
     wait for 100 ns;
     s <= '0';
     wait for 100 ns;
     r <= '1';
     wait for 100 ns;
     r <= '0';
     wait for 100 ns;
     s <= '1';
     r <= '1';
     wait for 100 ns;
     s <= '0';
     r <= '0';
     wait for 100 ns;
     s <= '1';
     r <= '1';
     wait for 100 ns;
   end process;
END;
