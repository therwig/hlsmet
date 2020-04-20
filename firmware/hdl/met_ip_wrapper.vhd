library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.met_data_types.all;


entity met_ip_wrapper is
  port (
    clk: in std_logic;
    rst: in std_logic;
    start: in std_logic;
    input: in met_data(N_MET_INPUTS-1 downto 0);
    done: out std_logic;
    idle: out std_logic;
    ready: out std_logic;
    output : out met_data(1 downto 0)
    );

end met_ip_wrapper;

architecture rtl of met_ip_wrapper is

begin

  met_algo : entity work.met_hw_0
    port map (
      ap_clk => clk,
      ap_rst => rst,
      ap_start => start, -- ??
      ap_done => done, -- ??
      ap_idle => idle, -- ??
      ap_ready => ready, -- ??
      inputs_0_V => input(0),
      inputs_1_V => input(1),
      inputs_2_V => input(2),
      inputs_3_V => input(3),
      inputs_4_V => input(4),
      inputs_5_V => input(5),
      inputs_6_V => input(6),
      inputs_7_V => input(7),
      inputs_8_V => input(8),
      inputs_9_V => input(9),
      inputs_10_V => input(10),
      inputs_11_V => input(11),
      inputs_12_V => input(12),
      inputs_13_V => input(13),
      inputs_14_V => input(14),
      inputs_15_V => input(15),
      inputs_16_V => input(16),
      inputs_17_V => input(17),
      inputs_18_V => input(18),
      inputs_19_V => input(19),
      inputs_20_V => input(20),
      inputs_21_V => input(21),
      inputs_22_V => input(22),
      inputs_23_V => input(23),
      inputs_24_V => input(24),
      inputs_25_V => input(25),
      inputs_26_V => input(26),
      inputs_27_V => input(27),
      inputs_28_V => input(28),
      inputs_29_V => input(29),
      inputs_30_V => input(30),
      inputs_31_V => input(31),
      inputs_32_V => input(32),
      inputs_33_V => input(33),
      inputs_34_V => input(34),
      inputs_35_V => input(35),
      inputs_36_V => input(36),
      inputs_37_V => input(37),
      inputs_38_V => input(38),
      inputs_39_V => input(39),
      inputs_40_V => input(40),
      inputs_41_V => input(41),
      inputs_42_V => input(42),
      inputs_43_V => input(43),
      inputs_44_V => input(44),
      inputs_45_V => input(45),
      inputs_46_V => input(46),
      inputs_47_V => input(47),
      inputs_48_V => input(48),
      inputs_49_V => input(49),
      inputs_50_V => input(50),
      inputs_51_V => input(51),
      inputs_52_V => input(52),
      inputs_53_V => input(53),
      inputs_54_V => input(54),
      inputs_55_V => input(55),
      inputs_56_V => input(56),
      inputs_57_V => input(57),
      inputs_58_V => input(58),
      inputs_59_V => input(59),
      output_V => output(0)
      );

end rtl;
              
