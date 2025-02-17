------------------------------------------------------------------
-- ALU
-- https://github.com/douggilliland/R32V2020/wiki/ALU

library ieee;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.numeric_std.all;

entity ALU is
	port (
		i_regDataA	: in std_logic_vector(31 downto 0) := x"00000000";
		i_regDataB	: in std_logic_vector(31 downto 0) := x"00000000";
		i_Op_ADS		: in std_logic := '0';
		i_Op_MUL		: in std_logic := '0';
		i_Op_CMP		: in std_logic := '0';
		i_Op_ARS		: in std_logic := '0';
		i_Op_XRS		: in std_logic := '0';
		i_Op_ORS		: in std_logic := '0';
		i_Op_LS1		: in std_logic := '0';
		i_Op_RS1		: in std_logic := '0';
		i_Op_LR1		: in std_logic := '0';
		i_Op_RR1		: in std_logic := '0';
		i_Op_RA1		: in std_logic := '0';
 		o_ALUDataOut	: out std_logic_vector(31 downto 0);
		o_CondCodeBits: out std_logic_vector(31 downto 0)
	);
end ALU;

architecture struct of ALU is

signal w_EqualToZero	: std_logic;
signal w_EqualToOne	: std_logic;
signal w_CarrySet		: std_logic;
signal w_CarryClear	: std_logic;
signal w_EqualCmp		: std_logic;
signal w_ALUResult	: std_logic_vector(31 downto 0);

begin

o_ALUDataOut <= w_ALUResult;

w_ALUResult <=  (i_regDataA + i_regDataB) when i_Op_ADS = '1' else
					(i_regDataA and i_regDataB) when i_Op_ARS = '1' else
					(i_regDataA or  i_regDataB) when i_Op_ORS  = '1' else
					(i_regDataA xor i_regDataB) when i_Op_XRS = '1' else
					(i_regDataA(30 downto 0)&'0') when i_Op_LS1 = '1' else
					('0'&i_regDataA(31 downto 1)) when i_Op_RS1 = '1' else
					(i_regDataA(30 downto 0)&i_regDataA(31)) when i_Op_LR1 = '1' else -- Needs to be rotate not shift
					(i_regDataA(0)&i_regDataA(31 downto 1)) when i_Op_RR1 = '1' else -- Needs to be rotate not shift
					(i_regDataA(31)&i_regDataA(31 downto 1)) when i_Op_RA1 = '1';

w_EqualToZero	<= '1' when w_ALUResult = x"00000000" else '0';
w_EqualToOne	<= '1' when w_ALUResult = x"00000001" else '0';
w_CarrySet		<= '1' when ((i_Op_ADS = '1') and (i_regDataA(31) = '1') and (i_regDataB(31) = '1')) else '0';
w_CarryClear	<= '1' when ((i_Op_ADS = '1') and ((i_regDataA(31) = '0') or  (i_regDataB(31) = '0'))) else '0';
w_EqualCmp    	<= '1' when (i_regDataA = i_regDataB) else '0';
--
o_CondCodeBits <= "000000000000000000000000000"&w_EqualCmp&w_CarryClear&w_CarrySet&w_EqualToOne&w_EqualToZero;

end struct;
