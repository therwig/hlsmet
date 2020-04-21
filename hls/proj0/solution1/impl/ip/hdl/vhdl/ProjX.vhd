-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
-- Version: 2019.2
-- Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ProjX is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    ap_ce : IN STD_LOGIC;
    pt_V : IN STD_LOGIC_VECTOR (15 downto 0);
    phi_V : IN STD_LOGIC_VECTOR (9 downto 0);
    ap_return : OUT STD_LOGIC_VECTOR (16 downto 0) );
end;


architecture behav of ProjX is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv32_8 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001000";
    constant ap_const_lv32_9 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001001";
    constant ap_const_lv2_1 : STD_LOGIC_VECTOR (1 downto 0) := "01";
    constant ap_const_lv8_FF : STD_LOGIC_VECTOR (7 downto 0) := "11111111";
    constant ap_const_lv10_2FF : STD_LOGIC_VECTOR (9 downto 0) := "1011111111";
    constant ap_const_lv10_300 : STD_LOGIC_VECTOR (9 downto 0) := "1100000000";
    constant ap_const_lv32_10 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000010000";
    constant ap_const_lv32_1F : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000011111";
    constant ap_const_lv17_0 : STD_LOGIC_VECTOR (16 downto 0) := "00000000000000000";

    signal ap_CS_fsm : STD_LOGIC_VECTOR (0 downto 0) := "1";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_enable_reg_pp0_iter0 : STD_LOGIC;
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter2 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter3 : STD_LOGIC := '0';
    signal ap_idle_pp0 : STD_LOGIC;
    signal ap_block_state1_pp0_stage0_iter0 : BOOLEAN;
    signal ap_block_state2_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_state3_pp0_stage0_iter2 : BOOLEAN;
    signal ap_block_state4_pp0_stage0_iter3 : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal cos_table1_address0 : STD_LOGIC_VECTOR (7 downto 0);
    signal cos_table1_ce0 : STD_LOGIC;
    signal cos_table1_q0 : STD_LOGIC_VECTOR (15 downto 0);
    signal pt_V_read_reg_185 : STD_LOGIC_VECTOR (15 downto 0);
    signal pt_V_read_reg_185_pp0_iter1_reg : STD_LOGIC_VECTOR (15 downto 0);
    signal icmp_ln891_fu_75_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln891_reg_190 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln891_reg_190_pp0_iter1_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln891_reg_190_pp0_iter2_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln887_fu_136_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln887_reg_200 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln887_reg_200_pp0_iter1_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln887_reg_200_pp0_iter2_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal cos_table1_load_reg_205 : STD_LOGIC_VECTOR (15 downto 0);
    signal ret_V_fu_179_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal ret_V_reg_210 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal zext_ln544_fu_131_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal tmp_34_fu_65_p4 : STD_LOGIC_VECTOR (1 downto 0);
    signal phiQ1_V_fu_61_p1 : STD_LOGIC_VECTOR (7 downto 0);
    signal phiQ1_V_4_fu_81_p2 : STD_LOGIC_VECTOR (7 downto 0);
    signal phiQ1_V_5_fu_87_p3 : STD_LOGIC_VECTOR (7 downto 0);
    signal icmp_ln891_2_fu_103_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal phiQ1_V_6_fu_109_p2 : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_35_fu_95_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal select_ln84_fu_115_p3 : STD_LOGIC_VECTOR (7 downto 0);
    signal select_ln887_fu_123_p3 : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_fu_148_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal zext_ln1503_fu_157_p1 : STD_LOGIC_VECTOR (16 downto 0);
    signal or_ln90_fu_161_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal sub_ln68_fu_165_p2 : STD_LOGIC_VECTOR (16 downto 0);
    signal ret_V_fu_179_p0 : STD_LOGIC_VECTOR (15 downto 0);
    signal ret_V_fu_179_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal ap_NS_fsm : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_idle_pp0_0to2 : STD_LOGIC;
    signal ap_reset_idle_pp0 : STD_LOGIC;
    signal ap_reset_start_pp0 : STD_LOGIC;
    signal ap_enable_pp0 : STD_LOGIC;
    signal ret_V_fu_179_p00 : STD_LOGIC_VECTOR (31 downto 0);
    signal ret_V_fu_179_p10 : STD_LOGIC_VECTOR (31 downto 0);

    component met_hw_mul_mul_16bkb IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        din0 : IN STD_LOGIC_VECTOR (15 downto 0);
        din1 : IN STD_LOGIC_VECTOR (15 downto 0);
        dout : OUT STD_LOGIC_VECTOR (31 downto 0) );
    end component;


    component ProjX_cos_table1 IS
    generic (
        DataWidth : INTEGER;
        AddressRange : INTEGER;
        AddressWidth : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR (7 downto 0);
        ce0 : IN STD_LOGIC;
        q0 : OUT STD_LOGIC_VECTOR (15 downto 0) );
    end component;



begin
    cos_table1_U : component ProjX_cos_table1
    generic map (
        DataWidth => 16,
        AddressRange => 256,
        AddressWidth => 8)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        address0 => cos_table1_address0,
        ce0 => cos_table1_ce0,
        q0 => cos_table1_q0);

    met_hw_mul_mul_16bkb_U1 : component met_hw_mul_mul_16bkb
    generic map (
        ID => 1,
        NUM_STAGE => 1,
        din0_WIDTH => 16,
        din1_WIDTH => 16,
        dout_WIDTH => 32)
    port map (
        din0 => ret_V_fu_179_p0,
        din1 => ret_V_fu_179_p1,
        dout => ret_V_fu_179_p2);





    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter1_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
            else
                if (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                    ap_enable_reg_pp0_iter1 <= ap_start;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter2_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter2 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter3_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter3 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter3 <= ap_enable_reg_pp0_iter2;
                end if; 
            end if;
        end if;
    end process;

    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_ce) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                cos_table1_load_reg_205 <= cos_table1_q0;
                icmp_ln887_reg_200 <= icmp_ln887_fu_136_p2;
                icmp_ln887_reg_200_pp0_iter1_reg <= icmp_ln887_reg_200;
                icmp_ln891_reg_190 <= icmp_ln891_fu_75_p2;
                icmp_ln891_reg_190_pp0_iter1_reg <= icmp_ln891_reg_190;
                pt_V_read_reg_185 <= pt_V;
                pt_V_read_reg_185_pp0_iter1_reg <= pt_V_read_reg_185;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_ce) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then
                icmp_ln887_reg_200_pp0_iter2_reg <= icmp_ln887_reg_200_pp0_iter1_reg;
                icmp_ln891_reg_190_pp0_iter2_reg <= icmp_ln891_reg_190_pp0_iter1_reg;
                ret_V_reg_210 <= ret_V_fu_179_p2;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_CS_fsm, ap_block_pp0_stage0_subdone, ap_reset_idle_pp0, ap_reset_start_pp0)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_pp0_stage0 => 
                ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
            when others =>  
                ap_NS_fsm <= "X";
        end case;
    end process;
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(0);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp0_stage0_11001_assign_proc : process(ap_start)
    begin
                ap_block_pp0_stage0_11001 <= ((ap_start = ap_const_logic_0) and (ap_start = ap_const_logic_1));
    end process;


    ap_block_pp0_stage0_subdone_assign_proc : process(ap_start, ap_ce)
    begin
                ap_block_pp0_stage0_subdone <= ((ap_const_logic_0 = ap_ce) or ((ap_start = ap_const_logic_0) and (ap_start = ap_const_logic_1)));
    end process;


    ap_block_state1_pp0_stage0_iter0_assign_proc : process(ap_start)
    begin
                ap_block_state1_pp0_stage0_iter0 <= (ap_start = ap_const_logic_0);
    end process;

        ap_block_state2_pp0_stage0_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state3_pp0_stage0_iter2 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state4_pp0_stage0_iter3 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_done_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0, ap_enable_reg_pp0_iter3, ap_block_pp0_stage0_11001, ap_ce)
    begin
        if ((((ap_start = ap_const_logic_0) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)) or ((ap_const_logic_1 = ap_ce) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter3 = ap_const_logic_1)))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_const_logic_0;
        end if; 
    end process;

    ap_enable_pp0 <= (ap_idle_pp0 xor ap_const_logic_1);
    ap_enable_reg_pp0_iter0 <= ap_start;

    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, ap_idle_pp0)
    begin
        if (((ap_start = ap_const_logic_0) and (ap_idle_pp0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp0_assign_proc : process(ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, ap_enable_reg_pp0_iter3)
    begin
        if (((ap_enable_reg_pp0_iter3 = ap_const_logic_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_0))) then 
            ap_idle_pp0 <= ap_const_logic_1;
        else 
            ap_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp0_0to2_assign_proc : process(ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2)
    begin
        if (((ap_enable_reg_pp0_iter2 = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_0))) then 
            ap_idle_pp0_0to2 <= ap_const_logic_1;
        else 
            ap_idle_pp0_0to2 <= ap_const_logic_0;
        end if; 
    end process;


    ap_ready_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001, ap_ce)
    begin
        if (((ap_const_logic_1 = ap_ce) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;


    ap_reset_idle_pp0_assign_proc : process(ap_start, ap_idle_pp0_0to2)
    begin
        if (((ap_start = ap_const_logic_0) and (ap_idle_pp0_0to2 = ap_const_logic_1))) then 
            ap_reset_idle_pp0 <= ap_const_logic_1;
        else 
            ap_reset_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;


    ap_reset_start_pp0_assign_proc : process(ap_start, ap_idle_pp0_0to2)
    begin
        if (((ap_start = ap_const_logic_1) and (ap_idle_pp0_0to2 = ap_const_logic_1))) then 
            ap_reset_start_pp0 <= ap_const_logic_1;
        else 
            ap_reset_start_pp0 <= ap_const_logic_0;
        end if; 
    end process;

    ap_return <= 
        sub_ln68_fu_165_p2 when (or_ln90_fu_161_p2(0) = '1') else 
        zext_ln1503_fu_157_p1;
    cos_table1_address0 <= zext_ln544_fu_131_p1(8 - 1 downto 0);

    cos_table1_ce0_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001, ap_ce)
    begin
        if (((ap_const_logic_1 = ap_ce) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            cos_table1_ce0 <= ap_const_logic_1;
        else 
            cos_table1_ce0 <= ap_const_logic_0;
        end if; 
    end process;

    icmp_ln887_fu_136_p2 <= "1" when (signed(phi_V) < signed(ap_const_lv10_300)) else "0";
    icmp_ln891_2_fu_103_p2 <= "1" when (signed(phi_V) > signed(ap_const_lv10_2FF)) else "0";
    icmp_ln891_fu_75_p2 <= "1" when (tmp_34_fu_65_p4 = ap_const_lv2_1) else "0";
    or_ln90_fu_161_p2 <= (icmp_ln891_reg_190_pp0_iter2_reg or icmp_ln887_reg_200_pp0_iter2_reg);
    phiQ1_V_4_fu_81_p2 <= (phiQ1_V_fu_61_p1 xor ap_const_lv8_FF);
    phiQ1_V_5_fu_87_p3 <= 
        phiQ1_V_4_fu_81_p2 when (icmp_ln891_fu_75_p2(0) = '1') else 
        phiQ1_V_fu_61_p1;
    phiQ1_V_6_fu_109_p2 <= (phiQ1_V_5_fu_87_p3 xor ap_const_lv8_FF);
    phiQ1_V_fu_61_p1 <= phi_V(8 - 1 downto 0);
    ret_V_fu_179_p0 <= ret_V_fu_179_p00(16 - 1 downto 0);
    ret_V_fu_179_p00 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(pt_V_read_reg_185_pp0_iter1_reg),32));
    ret_V_fu_179_p1 <= ret_V_fu_179_p10(16 - 1 downto 0);
    ret_V_fu_179_p10 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(cos_table1_load_reg_205),32));
    select_ln84_fu_115_p3 <= 
        phiQ1_V_6_fu_109_p2 when (icmp_ln891_2_fu_103_p2(0) = '1') else 
        phiQ1_V_5_fu_87_p3;
    select_ln887_fu_123_p3 <= 
        select_ln84_fu_115_p3 when (tmp_35_fu_95_p3(0) = '1') else 
        phiQ1_V_5_fu_87_p3;
    sub_ln68_fu_165_p2 <= std_logic_vector(unsigned(ap_const_lv17_0) - unsigned(zext_ln1503_fu_157_p1));
    tmp_34_fu_65_p4 <= phi_V(9 downto 8);
    tmp_35_fu_95_p3 <= phi_V(9 downto 9);
    tmp_fu_148_p4 <= ret_V_reg_210(31 downto 16);
    zext_ln1503_fu_157_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(tmp_fu_148_p4),17));
    zext_ln544_fu_131_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(select_ln887_fu_123_p3),64));
end behav;
