-- HLS plus 7 test

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

use work.ipbus.all;
use work.emp_data_types.all;
use work.emp_project_decl.all;

use work.emp_device_decl.all;
use work.emp_ttc_decl.all;

use work.met_data_types.all;

entity emp_payload is
  port(
    clk: in std_logic; -- ipbus signals
    rst: in std_logic;
    ipb_in: in ipb_wbus;
    ipb_out: out ipb_rbus;
    clk_payload: in std_logic_vector(2 downto 0);
    rst_payload: in std_logic_vector(2 downto 0);
    clk_p: in std_logic; -- data clock
    rst_loc: in std_logic_vector(N_REGION - 1 downto 0);
    clken_loc: in std_logic_vector(N_REGION - 1 downto 0);
    ctrs: in ttc_stuff_array;
    bc0: out std_logic;
    d: in ldata(4 * N_REGION - 1 downto 0); -- data in
    q: out ldata(4 * N_REGION - 1 downto 0); -- data out
    gpio: out std_logic_vector(29 downto 0); -- IO to mezzanine connector
    gpio_en: out std_logic_vector(29 downto 0) -- IO to mezzanine connector (three-state enables)
    );
  
end emp_payload;

architecture rtl of emp_payload is
  
  constant IN_BUFFER_LEN : integer := 6;
  constant OUT_BUFFER_LEN : integer := 6;
--  type dmet_t is array(PAYLOAD_LATENCY-1 downto 0) of met_data(N_MET_INPUTS-1 downto 0);
  --signal dmet: array(PAYLOAD_LATENCY-1 downto 0) of met_data(N_MET_INPUTS-1 downto 0);
  signal dmet: met_data_array(IN_BUFFER_LEN-1 downto 0)(N_MET_INPUTS-1 downto 0);
  signal qmet: met_data_array(OUT_BUFFER_LEN-1 downto 0)(0 downto 0);
begin

  ipb_out <= IPB_RBUS_NULL;

  --signal dmet: dmet_t;
  gen: for i in N_MET_INPUTS - 1 downto 0 generate
  begin
    dmet(0)(i) <= d(i).data;
  end generate;

  -- Pipe the input for SLR crossings
  dmet(IN_BUFFER_LEN-1 downto 1) <= dmet(IN_BUFFER_LEN-2 downto 0) when rising_edge(clk_p);
  qmet(OUT_BUFFER_LEN-1 downto 1) <= qmet(OUT_BUFFER_LEN-2 downto 0) when rising_edge(clk_p);
  
  met_algo : entity work.met_ip_wrapper
    PORT MAP (
      clk    => clk_p,
      rst    => rst, --_loc(i),
      start => '1',
      done => open,
      idle => open,
      ready => open,
      input => dmet(IN_BUFFER_LEN-1),
      output => qmet(0)
      );

  --qmet(0) => q(0).data;
  q(0).data   <= qmet(OUT_BUFFER_LEN-1)(0);
  q(0).valid  <= '1';
  q(0).strobe <= '1';
  q(4 * N_REGION - 1 downto 1) <= (others => lword_null);
  
  bc0 <= '0';
  
  gpio <= (others => '0');
  gpio_en <= (others => '0');

end rtl;
