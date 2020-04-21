-- ==============================================================
-- Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.1 (64-bit)
-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity ProjY_sin_table2_rom is 
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


architecture rtl of ProjY_sin_table2_rom is 

signal addr0_tmp : std_logic_vector(AWIDTH-1 downto 0); 
type mem_array is array (0 to MEM_SIZE-1) of std_logic_vector (DWIDTH-1 downto 0); 
signal mem : mem_array := (
    0 => "0000000000000000", 1 => "0000000110010010", 2 => "0000001100100100", 
    3 => "0000010010110110", 4 => "0000011001001000", 5 => "0000011111011010", 
    6 => "0000100101101100", 7 => "0000101011111110", 8 => "0000110010010000", 
    9 => "0000111000100001", 10 => "0000111110110011", 11 => "0001000101000100", 
    12 => "0001001011010101", 13 => "0001010001100110", 14 => "0001010111110111", 
    15 => "0001011110000111", 16 => "0001100100011000", 17 => "0001101010101000", 
    18 => "0001110000111000", 19 => "0001110111000111", 20 => "0001111101010110", 
    21 => "0010000011100101", 22 => "0010001001110100", 23 => "0010010000000010", 
    24 => "0010010110010000", 25 => "0010011100011110", 26 => "0010100010101011", 
    27 => "0010101000111000", 28 => "0010101111000100", 29 => "0010110101010000", 
    30 => "0010111011011100", 31 => "0011000001100111", 32 => "0011000111110001", 
    33 => "0011001101111100", 34 => "0011010100000101", 35 => "0011011010001110", 
    36 => "0011100000010111", 37 => "0011100110011111", 38 => "0011101100100111", 
    39 => "0011110010101110", 40 => "0011111000110100", 41 => "0011111110111010", 
    42 => "0100000100111111", 43 => "0100001011000011", 44 => "0100010001000111", 
    45 => "0100010111001011", 46 => "0100011101001101", 47 => "0100100011001111", 
    48 => "0100101001010000", 49 => "0100101111010001", 50 => "0100110101010000", 
    51 => "0100111011001111", 52 => "0101000001001101", 53 => "0101000111001011", 
    54 => "0101001101001000", 55 => "0101010011000011", 56 => "0101011000111110", 
    57 => "0101011110111001", 58 => "0101100100110010", 59 => "0101101010101010", 
    60 => "0101110000100010", 61 => "0101110110011001", 62 => "0101111100001111", 
    63 => "0110000010000100", 64 => "0110000111111000", 65 => "0110001101101011", 
    66 => "0110010011011101", 67 => "0110011001001110", 68 => "0110011110111110", 
    69 => "0110100100101101", 70 => "0110101010011011", 71 => "0110110000001000", 
    72 => "0110110101110100", 73 => "0110111011011111", 74 => "0111000001001001", 
    75 => "0111000110110010", 76 => "0111001100011010", 77 => "0111010010000000", 
    78 => "0111010111100110", 79 => "0111011101001010", 80 => "0111100010101101", 
    81 => "0111101000010000", 82 => "0111101101110000", 83 => "0111110011010000", 
    84 => "0111111000101111", 85 => "0111111110001100", 86 => "1000000011101000", 
    87 => "1000001001000011", 88 => "1000001110011100", 89 => "1000010011110101", 
    90 => "1000011001001100", 91 => "1000011110100001", 92 => "1000100011110110", 
    93 => "1000101001001001", 94 => "1000101110011010", 95 => "1000110011101011", 
    96 => "1000111000111010", 97 => "1000111110001000", 98 => "1001000011010100", 
    99 => "1001001000011111", 100 => "1001001101101000", 101 => "1001010010110000", 
    102 => "1001010111110111", 103 => "1001011100111100", 104 => "1001100010000000", 
    105 => "1001100111000010", 106 => "1001101100000011", 107 => "1001110001000010", 
    108 => "1001110110000000", 109 => "1001111010111100", 110 => "1001111111110111", 
    111 => "1010000100110000", 112 => "1010001001101000", 113 => "1010001110011110", 
    114 => "1010010011010010", 115 => "1010011000000101", 116 => "1010011100110110", 
    117 => "1010100001100110", 118 => "1010100110010100", 119 => "1010101011000001", 
    120 => "1010101111101011", 121 => "1010110100010100", 122 => "1010111000111100", 
    123 => "1010111101100010", 124 => "1011000010000110", 125 => "1011000110101000", 
    126 => "1011001011001001", 127 => "1011001111101000", 128 => "1011010100000101", 
    129 => "1011011000100000", 130 => "1011011100111010", 131 => "1011100001010010", 
    132 => "1011100101101000", 133 => "1011101001111101", 134 => "1011101110001111", 
    135 => "1011110010100000", 136 => "1011110110101111", 137 => "1011111010111100", 
    138 => "1011111111000111", 139 => "1100000011010001", 140 => "1100000111011000", 
    141 => "1100001011011110", 142 => "1100001111100010", 143 => "1100010011100100", 
    144 => "1100010111100100", 145 => "1100011011100010", 146 => "1100011111011110", 
    147 => "1100100011011001", 148 => "1100100111010001", 149 => "1100101011001000", 
    150 => "1100101110111100", 151 => "1100110010101110", 152 => "1100110110011111", 
    153 => "1100111010001110", 154 => "1100111101111010", 155 => "1101000001100101", 
    156 => "1101000101001101", 157 => "1101001000110100", 158 => "1101001100011000", 
    159 => "1101001111111011", 160 => "1101010011011011", 161 => "1101010110111010", 
    162 => "1101011010010110", 163 => "1101011101110000", 164 => "1101100001001000", 
    165 => "1101100100011110", 166 => "1101100111110010", 167 => "1101101011000100", 
    168 => "1101101110010100", 169 => "1101110001100010", 170 => "1101110100101101", 
    171 => "1101110111110111", 172 => "1101111010111110", 173 => "1101111110000011", 
    174 => "1110000001000110", 175 => "1110000100000111", 176 => "1110000111000110", 
    177 => "1110001010000010", 178 => "1110001100111100", 179 => "1110001111110100", 
    180 => "1110010010101010", 181 => "1110010101011110", 182 => "1110011000010000", 
    183 => "1110011010111111", 184 => "1110011101101100", 185 => "1110100000010111", 
    186 => "1110100010111111", 187 => "1110100101100110", 188 => "1110101000001010", 
    189 => "1110101010101011", 190 => "1110101101001011", 191 => "1110101111101000", 
    192 => "1110110010000011", 193 => "1110110100011100", 194 => "1110110110110011", 
    195 => "1110111001000111", 196 => "1110111011011001", 197 => "1110111101101000", 
    198 => "1110111111110101", 199 => "1111000010000000", 200 => "1111000100001001", 
    201 => "1111000110001111", 202 => "1111001000010011", 203 => "1111001010010101", 
    204 => "1111001100010100", 205 => "1111001110010001", 206 => "1111010000001100", 
    207 => "1111010010000100", 208 => "1111010011111010", 209 => "1111010101101110", 
    210 => "1111010111011111", 211 => "1111011001001110", 212 => "1111011010111010", 
    213 => "1111011100100100", 214 => "1111011110001100", 215 => "1111011111110001", 
    216 => "1111100001010100", 217 => "1111100010110100", 218 => "1111100100010011", 
    219 => "1111100101101110", 220 => "1111100111001000", 221 => "1111101000011111", 
    222 => "1111101001110011", 223 => "1111101011000101", 224 => "1111101100010101", 
    225 => "1111101101100010", 226 => "1111101110101101", 227 => "1111101111110101", 
    228 => "1111110000111011", 229 => "1111110001111111", 230 => "1111110011000000", 
    231 => "1111110011111110", 232 => "1111110100111011", 233 => "1111110101110100", 
    234 => "1111110110101100", 235 => "1111110111100001", 236 => "1111111000010011", 
    237 => "1111111001000011", 238 => "1111111001110001", 239 => "1111111010011100", 
    240 => "1111111011000100", 241 => "1111111011101011", 242 => "1111111100001110", 
    243 => "1111111100110000", 244 => "1111111101001110", 245 => "1111111101101011", 
    246 => "1111111110000101", 247 => "1111111110011100", 248 => "1111111110110001", 
    249 => "1111111111000100", 250 => "1111111111010100", 251 => "1111111111100001", 
    252 => "1111111111101100", 253 => "1111111111110101", 254 => "1111111111111011", 
    255 => "1111111111111111" );


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

entity ProjY_sin_table2 is
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

architecture arch of ProjY_sin_table2 is
    component ProjY_sin_table2_rom is
        port (
            clk : IN STD_LOGIC;
            addr0 : IN STD_LOGIC_VECTOR;
            ce0 : IN STD_LOGIC;
            q0 : OUT STD_LOGIC_VECTOR);
    end component;



begin
    ProjY_sin_table2_rom_U :  component ProjY_sin_table2_rom
    port map (
        clk => clk,
        addr0 => address0,
        ce0 => ce0,
        q0 => q0);

end architecture;


