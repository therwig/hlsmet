-- ==============================================================
-- Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2 (64-bit)
-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity ProjX_cos_table1_rom is 
    generic(
             DWIDTH     : integer := 16; 
             AWIDTH     : integer := 8; 
             MEM_SIZE    : integer := 256
    ); 
    port (
          addr0      : in std_logic_vector(AWIDTH-1 downto 0); 
          ce0       : in std_logic; 
          q0         : out std_logic_vector(DWIDTH-1 downto 0);
          clk       : in std_logic
    ); 
end entity; 


architecture rtl of ProjX_cos_table1_rom is 

signal addr0_tmp : std_logic_vector(AWIDTH-1 downto 0); 
type mem_array is array (0 to MEM_SIZE-1) of std_logic_vector (DWIDTH-1 downto 0); 
signal mem : mem_array := (
    0 to 1=> "1111111111111111", 2 => "1111111111111011", 3 => "1111111111110101", 
    4 => "1111111111101100", 5 => "1111111111100001", 6 => "1111111111010100", 
    7 => "1111111111000100", 8 => "1111111110110001", 9 => "1111111110011100", 
    10 => "1111111110000101", 11 => "1111111101101011", 12 => "1111111101001110", 
    13 => "1111111100110000", 14 => "1111111100001110", 15 => "1111111011101011", 
    16 => "1111111011000100", 17 => "1111111010011100", 18 => "1111111001110001", 
    19 => "1111111001000011", 20 => "1111111000010011", 21 => "1111110111100001", 
    22 => "1111110110101100", 23 => "1111110101110100", 24 => "1111110100111011", 
    25 => "1111110011111110", 26 => "1111110011000000", 27 => "1111110001111111", 
    28 => "1111110000111011", 29 => "1111101111110101", 30 => "1111101110101101", 
    31 => "1111101101100010", 32 => "1111101100010101", 33 => "1111101011000101", 
    34 => "1111101001110011", 35 => "1111101000011111", 36 => "1111100111001000", 
    37 => "1111100101101110", 38 => "1111100100010011", 39 => "1111100010110100", 
    40 => "1111100001010100", 41 => "1111011111110001", 42 => "1111011110001100", 
    43 => "1111011100100100", 44 => "1111011010111010", 45 => "1111011001001110", 
    46 => "1111010111011111", 47 => "1111010101101110", 48 => "1111010011111010", 
    49 => "1111010010000100", 50 => "1111010000001100", 51 => "1111001110010001", 
    52 => "1111001100010100", 53 => "1111001010010101", 54 => "1111001000010011", 
    55 => "1111000110001111", 56 => "1111000100001001", 57 => "1111000010000000", 
    58 => "1110111111110101", 59 => "1110111101101000", 60 => "1110111011011001", 
    61 => "1110111001000111", 62 => "1110110110110011", 63 => "1110110100011100", 
    64 => "1110110010000011", 65 => "1110101111101000", 66 => "1110101101001011", 
    67 => "1110101010101011", 68 => "1110101000001010", 69 => "1110100101100110", 
    70 => "1110100010111111", 71 => "1110100000010111", 72 => "1110011101101100", 
    73 => "1110011010111111", 74 => "1110011000010000", 75 => "1110010101011110", 
    76 => "1110010010101010", 77 => "1110001111110100", 78 => "1110001100111100", 
    79 => "1110001010000010", 80 => "1110000111000110", 81 => "1110000100000111", 
    82 => "1110000001000110", 83 => "1101111110000011", 84 => "1101111010111110", 
    85 => "1101110111110111", 86 => "1101110100101101", 87 => "1101110001100010", 
    88 => "1101101110010100", 89 => "1101101011000100", 90 => "1101100111110010", 
    91 => "1101100100011110", 92 => "1101100001001000", 93 => "1101011101110000", 
    94 => "1101011010010110", 95 => "1101010110111010", 96 => "1101010011011011", 
    97 => "1101001111111011", 98 => "1101001100011000", 99 => "1101001000110100", 
    100 => "1101000101001101", 101 => "1101000001100101", 102 => "1100111101111010", 
    103 => "1100111010001110", 104 => "1100110110011111", 105 => "1100110010101110", 
    106 => "1100101110111100", 107 => "1100101011000111", 108 => "1100100111010001", 
    109 => "1100100011011001", 110 => "1100011111011110", 111 => "1100011011100010", 
    112 => "1100010111100100", 113 => "1100010011100100", 114 => "1100001111100010", 
    115 => "1100001011011110", 116 => "1100000111011000", 117 => "1100000011010001", 
    118 => "1011111111000111", 119 => "1011111010111100", 120 => "1011110110101111", 
    121 => "1011110010100000", 122 => "1011101110001111", 123 => "1011101001111101", 
    124 => "1011100101101000", 125 => "1011100001010010", 126 => "1011011100111010", 
    127 => "1011011000100000", 128 => "1011010100000101", 129 => "1011001111101000", 
    130 => "1011001011001001", 131 => "1011000110101000", 132 => "1011000010000110", 
    133 => "1010111101100010", 134 => "1010111000111100", 135 => "1010110100010100", 
    136 => "1010101111101011", 137 => "1010101011000001", 138 => "1010100110010100", 
    139 => "1010100001100110", 140 => "1010011100110110", 141 => "1010011000000101", 
    142 => "1010010011010010", 143 => "1010001110011110", 144 => "1010001001101000", 
    145 => "1010000100110000", 146 => "1001111111110111", 147 => "1001111010111100", 
    148 => "1001110110000000", 149 => "1001110001000010", 150 => "1001101100000011", 
    151 => "1001100111000010", 152 => "1001100010000000", 153 => "1001011100111100", 
    154 => "1001010111110111", 155 => "1001010010110000", 156 => "1001001101101000", 
    157 => "1001001000011111", 158 => "1001000011010100", 159 => "1000111110001000", 
    160 => "1000111000111010", 161 => "1000110011101011", 162 => "1000101110011010", 
    163 => "1000101001001001", 164 => "1000100011110110", 165 => "1000011110100001", 
    166 => "1000011001001100", 167 => "1000010011110101", 168 => "1000001110011100", 
    169 => "1000001001000011", 170 => "1000000011101000", 171 => "0111111110001100", 
    172 => "0111111000101111", 173 => "0111110011010000", 174 => "0111101101110000", 
    175 => "0111101000010000", 176 => "0111100010101101", 177 => "0111011101001010", 
    178 => "0111010111100110", 179 => "0111010010000000", 180 => "0111001100011010", 
    181 => "0111000110110010", 182 => "0111000001001001", 183 => "0110111011011111", 
    184 => "0110110101110100", 185 => "0110110000001000", 186 => "0110101010011011", 
    187 => "0110100100101101", 188 => "0110011110111110", 189 => "0110011001001110", 
    190 => "0110010011011101", 191 => "0110001101101011", 192 => "0110000111111000", 
    193 => "0110000010000100", 194 => "0101111100001111", 195 => "0101110110011001", 
    196 => "0101110000100010", 197 => "0101101010101010", 198 => "0101100100110010", 
    199 => "0101011110111001", 200 => "0101011000111110", 201 => "0101010011000011", 
    202 => "0101001101001000", 203 => "0101000111001011", 204 => "0101000001001101", 
    205 => "0100111011001111", 206 => "0100110101010000", 207 => "0100101111010001", 
    208 => "0100101001010000", 209 => "0100100011001111", 210 => "0100011101001101", 
    211 => "0100010111001011", 212 => "0100010001000111", 213 => "0100001011000011", 
    214 => "0100000100111111", 215 => "0011111110111010", 216 => "0011111000110100", 
    217 => "0011110010101110", 218 => "0011101100100111", 219 => "0011100110011111", 
    220 => "0011100000010111", 221 => "0011011010001110", 222 => "0011010100000101", 
    223 => "0011001101111100", 224 => "0011000111110001", 225 => "0011000001100111", 
    226 => "0010111011011100", 227 => "0010110101010000", 228 => "0010101111000100", 
    229 => "0010101000111000", 230 => "0010100010101011", 231 => "0010011100011110", 
    232 => "0010010110010000", 233 => "0010010000000010", 234 => "0010001001110100", 
    235 => "0010000011100101", 236 => "0001111101010110", 237 => "0001110111000111", 
    238 => "0001110000111000", 239 => "0001101010101000", 240 => "0001100100011000", 
    241 => "0001011110000111", 242 => "0001010111110111", 243 => "0001010001100110", 
    244 => "0001001011010101", 245 => "0001000101000100", 246 => "0000111110110011", 
    247 => "0000111000100001", 248 => "0000110010010000", 249 => "0000101011111110", 
    250 => "0000100101101100", 251 => "0000011111011010", 252 => "0000011001001000", 
    253 => "0000010010110110", 254 => "0000001100100100", 255 => "0000000110010010" );


begin 


memory_access_guard_0: process (addr0) 
begin
      addr0_tmp <= addr0;
--synthesis translate_off
      if (CONV_INTEGER(addr0) > mem_size-1) then
           addr0_tmp <= (others => '0');
      else 
           addr0_tmp <= addr0;
      end if;
--synthesis translate_on
end process;

p_rom_access: process (clk)  
begin 
    if (clk'event and clk = '1') then
        if (ce0 = '1') then 
            q0 <= mem(CONV_INTEGER(addr0_tmp)); 
        end if;
    end if;
end process;

end rtl;

Library IEEE;
use IEEE.std_logic_1164.all;

entity ProjX_cos_table1 is
    generic (
        DataWidth : INTEGER := 16;
        AddressRange : INTEGER := 256;
        AddressWidth : INTEGER := 8);
    port (
        reset : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR(AddressWidth - 1 DOWNTO 0);
        ce0 : IN STD_LOGIC;
        q0 : OUT STD_LOGIC_VECTOR(DataWidth - 1 DOWNTO 0));
end entity;

architecture arch of ProjX_cos_table1 is
    component ProjX_cos_table1_rom is
        port (
            clk : IN STD_LOGIC;
            addr0 : IN STD_LOGIC_VECTOR;
            ce0 : IN STD_LOGIC;
            q0 : OUT STD_LOGIC_VECTOR);
    end component;



begin
    ProjX_cos_table1_rom_U :  component ProjX_cos_table1_rom
    port map (
        clk => clk,
        addr0 => address0,
        ce0 => ce0,
        q0 => q0);

end architecture;


