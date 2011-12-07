LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
    COMPONENT counter
    port (b : inout std_logic_vector(15 downto 0);
          tc : out std_logic;
          clk : in std_logic;
          cen : in std_logic;
          rst : in std_logic);
    END COMPONENT;

   --Inputs
   signal clk : std_logic := '0';
   signal cen : std_logic := '1';
   signal rst : std_logic := '0';

 	--Outputs
   signal b : std_logic_vector(15 downto 0);
   signal tc : std_logic := '0';
 
   constant period : time := 10 ns;
   constant clk_period : time := 10 ns;

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
   uut: counter_16bit PORT MAP (
       tc => tc, clk => clk, cen => cen, rst => rst, b => b
        );

  -- Clock process
  clk_proc: process
  begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
  end process;

--   -- Stimulus process
--   stim_proc: process
--   begin
--   end process;
END;
