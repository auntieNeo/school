LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
    COMPONENT cpg_adder
    PORT(
         a, b : IN  std_logic_vector(7 downto 0);
         cin : in std_logic;
         s : OUT  std_logic_vector(7 downto 0);
         cout : out std_logic
        );
    END COMPONENT;

   --Inputs
   signal a : std_logic_vector(7 downto 0) := "00000000";
   signal b : std_logic_vector(7 downto 0) := "00000000";
   signal cin : std_logic := '0';

 	--Outputs
   signal s : std_logic_vector(7 downto 0);
   signal cout : std_logic;
 
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
   uut: cpg_adder PORT MAP (
          a => a,
          b => b,
          cin => cin,
          s => s,
          cout => cout
        );

   -- Stimulus process
   stim_proc: process
   begin		
      cin <= '0';
      for I in 0 to 1 loop
        for J in 0 to 1 loop
          for K in 0 to 1 loop
            for L in 0 to 1 loop
              for M in 0 to 1 loop
                for N in 0 to 1 loop
                  for O in 0 to 1 loop
                    for P in 0 to 1 loop
                      for Q in 0 to 1 loop
                        for R in 0 to 1 loop
                          for S in 0 to 1 loop
                            for T in 0 to 1 loop
                              for U in 0 to 1 loop
                                for V in 0 to 1 loop
                                  for W in 0 to 1 loop
                                    for X in 0 to 1 loop
                                      a(7)<= to_logic(I);
                                      a(6)<= to_logic(J);
                                      a(5)<= to_logic(K);
                                      a(4)<= to_logic(L);
                                      a(3)<= to_logic(M);
                                      a(2)<= to_logic(N);
                                      a(1)<= to_logic(O);
                                      a(0)<= to_logic(P);
                                      b(7)<= to_logic(Q);
                                      b(6)<= to_logic(R);
                                      b(5)<= to_logic(S);
                                      b(4)<= to_logic(T);
                                      b(3)<= to_logic(U);
                                      b(2)<= to_logic(V);
                                      b(1)<= to_logic(W);
                                      b(0)<= to_logic(X);
                                      wait for period;
                                    end loop;
                                  end loop;
                                end loop;
                              end loop;
                            end loop;
                          end loop;
                        end loop;
                      end loop;
                    end loop;
                  end loop;
                end loop;
              end loop;
            end loop;
          end loop;
        end loop;
      end loop;
   end process;

END;
