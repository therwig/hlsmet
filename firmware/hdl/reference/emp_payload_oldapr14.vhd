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
  
  constant PAYLOAD_LATENCY : integer := 36;
  --type dr_t is array(PAYLOAD_LATENCY downto 0) of ldata(N_MET_INPUTS-1 downto 0);
  --type dr_t is array(PAYLOAD_LATENCY downto 0) of met_data(N_MET_INPUTS-1 downto 0);
  --signal d_pf : pf_data_array(N_PF_IP_CORES - 1 downto 0)(N_PF_IP_CORE_IN_CHANS - 1 downto 0);
  --type rmet is array(PAYLOAD_LATENCY downto 0) of met_data(N_MET_INPUTS-1 downto 0);
  --type qmet is array(PAYLOAD_LATENCY downto 0) of met_data;

begin


  ipb_out <= IPB_RBUS_NULL;


  --gen: for i in N_MET_INPUTS - 1 downto 0 generate
  --  signal dr: dr_t;    
  --  attribute SHREG_EXTRACT: string;
  --  attribute SHREG_EXTRACT of dr: signal is "no"; -- Don't absorb FFs into shreg

  --begin
  --  rmet(0)(i) <= d(i).data;

  signal dmet : met_data(N_MET_INPUTS-1 downto 0)
  gen: for i in N_MET_INPUTS - 1 downto 0 generate
  begin
    dmet(i) <= d(i).data;
  end generate;
  
  met_algo : entity work.met_ip_wrapper
    PORT MAP (
      clk    => clk_p,
      rst    => rst_loc(i),
      start => '1',
      done => open,
      idle => open,
      ready => open,
      input => dmet,
      output => q(0).data
      );

  --q(0) 
    
  -- gen: for i in N_REGION - 1 downto 0 generate
  --  constant ich: integer := i * 4 + 3;
  --  constant icl: integer := i * 4;
  --  signal dr: dr_t;
    
  --  attribute SHREG_EXTRACT: string;
  --  attribute SHREG_EXTRACT of dr: signal is "no"; -- Don't absorb FFs into shreg

  --begin
    
    --gen: for j in 3 downto 0 generate

    --  met_algo : entity work.met_ip_wrapper
    --    PORT MAP (
    --      clk    => clk_p,
    --      rst    => rst_loc(i),
    --      start => '1',
    --      done => open,
    --      idle => open,
    --      ready => open,
    --      --ap_return => dr(0)(j).data,
    --      --a_V => d(icl+j).data
    --      input => d,
    --      output => dr(0)(j).data
    --      );
      
    --  dr(0)(j).valid <= d(icl).valid;
    --  dr(0)(j).start <= d(icl).start;
    --  dr(0)(j).strobe <= d(icl).strobe;

    --end generate;


    --process(clk_p) -- Mother of all shift registers
    --begin
    --  if rising_edge(clk_p) then
    --    --dr(PAYLOAD_LATENCY downto 1) <= dr(PAYLOAD_LATENCY - 1 downto 0);
    --    rmet(PAYLOAD_LATENCY downto 1) <= rmet(PAYLOAD_LATENCY - 1 downto 0);
    --  end if;
    --end process;

    --q(ich downto icl) <= rmet(PAYLOAD_LATENCY) ;

    
  --end generate;
  
  bc0 <= '0';
  
  gpio <= (others => '0');
  gpio_en <= (others => '0');

end rtl;
