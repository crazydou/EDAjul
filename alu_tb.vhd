library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.conv_std_logic_vector;
use ieee.std_logic_unsigned.ALL;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;


entity alu_tb is
end entity alu_tb;

architecture tb of alu_tb is
--测试元件声明
  component alu
    port(
		CS:IN STD_LOGIC_VECTOR(2 DOWNTO 0);         --Operation Code 
		data_a:IN STD_LOGIC_VECTOR(7 DOWNTO 0);	    --Input number 1
		data_b:IN STD_LOGIC_VECTOR(7 DOWNTO 0);		--Input number 2
		carry_in:IN STD_LOGIC;	                    --Carry In
		S:OUT STD_LOGIC_VECTOR(7 DOWNTO 0);	  		--Input number 1
		zero:OUT STD_LOGIC;                 		--Input number 2
		carry_out:OUT STD_LOGIC	                    --Carry Out
		);
  end component;
--测试用的信号和参数  
  
SIGNAL CS: STD_LOGIC_VECTOR(2 DOWNTO 0);         --Operation Code 
SIGNAL data_a: STD_LOGIC_VECTOR(7 DOWNTO 0);	    --Input number 1
SIGNAL data_b: STD_LOGIC_VECTOR(7 DOWNTO 0);		--Input number 2
SIGNAL carry_in: STD_LOGIC;	                    --Carry In
SIGNAL	S: STD_LOGIC_VECTOR(7 DOWNTO 0);	  		--Input number 1
SIGNAL zero: STD_LOGIC;                 		--Input number 2
SIGNAL carry_out: STD_LOGIC;	                    --Carry Out
  
  
  constant ClockPeriod:time:=2 ns;
--验证用的相关说明，将被测信息打印出来，可以去掉，直接观察波形！  
  file so:text;
begin


 c_divider:alu port map (CS=>CS,data_a=>data_a,data_b=>data_b,carry_in=>carry_in,S=>S,zero=>zero,carry_out=>carry_out);
  

test:process
  begin
    CS<="000";data_a<="11111110";data_b<="00000101";carry_in<='1';
	wait for ClockPeriod*50;
	
	CS<="000";data_a<="11111111";data_b<="11111111";carry_in<='1';
	wait for ClockPeriod*50;
    CS<="001";data_a<="00000010";data_b<="00100010";carry_in<='0';
	wait for ClockPeriod*50;
	CS<="001";data_b<="00000010";data_a<="00100010";carry_in<='0';
	wait for ClockPeriod*50;
	CS<="010";data_a<="00000010";data_b<="00100010";carry_in<='0';
	wait for ClockPeriod*50;
	CS<="011";data_a<="00000010";data_b<="00100010";carry_in<='0';
	wait for ClockPeriod*50;
	CS<="100";data_a<="00000010";data_b<="00100010";carry_in<='0';
	wait for ClockPeriod*50;                           --One click Two key
  end process;
  
  
end tb;
