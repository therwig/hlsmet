library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- custom data type
package met_data_types is
  constant N_MET_INPUTS : integer := 60;
  type met_data is array (natural range <>) of std_logic_vector(63 downto 0);
  type met_data_array is array (natural range <>) of met_data;
end;
