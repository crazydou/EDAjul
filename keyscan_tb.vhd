library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.conv_std_logic_vector;
use ieee.std_logic_unsigned.ALL;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;


entity keyscan_tb is
end entity keyscan_tb;

architecture tb of keyscan_tb is
--测试元件声明
  component keyboard_ev
    port(
      CLK  : in  std_logic;
    V  : in  std_logic_vector(3 downto 0);--supporting that there is only one signal
    O  : out std_logic_vector(3 downto 0);--give the transformation of the matrix keyboard in binary
	D  : out std_logic;--inform the state of the curiut
    H  : out std_logic_vector(3 downto 0)--to scan the keyboard
    );
  end component;
--测试用的信号和参数  
  
  signal V,O,H:std_logic_vector(3 downto 0);
  signal CLK,D,erro:std_logic;
  constant ClockPeriod:time:=2 ns;
--验证用的相关说明，将被测信息打印出来，可以去掉，直接观察波形！  
  file so:text;
begin


  c_divider:keyboard_ev port map (clk=>clk,V=>V,O=>O,D=>D,H=>H);
  
  p_clk:process
  begin
    clk<='0';
    wait for ClockPeriod/2;
    clk<='1';
    wait for ClockPeriod/2;
  end process;
--verfication  


test:process
  begin
    V<="0001";
	wait for ClockPeriod*15;
	V<="0000";
	wait for ClockPeriod*15;
	V<="0010";
	wait for ClockPeriod*15;
	V<="0000";
	wait for ClockPeriod*15;
	V<="0100";
	wait for ClockPeriod*15;
	V<="0000";
	wait for ClockPeriod*15;
	V<="1000";
	wait for ClockPeriod*15;
	V<="0000";
	wait for ClockPeriod*30;             --Longtime one key	
	
	V<="1000";
	wait for ClockPeriod*15;
	V<="0000";
	wait for ClockPeriod*15;
	V<="1000";
	wait for ClockPeriod*15;
	V<="0000";
	wait for ClockPeriod*30;	         --Double Click one key
	
	
	V<="0011";
	wait for ClockPeriod*12;
	V<="0000";
	wait for ClockPeriod*1;
	V<="0011";
	wait for ClockPeriod*2;
	V<="0000";
	wait for ClockPeriod*30;              --Simulate Trimble
	
	
	V<="0011";
	wait for ClockPeriod*15;
	V<="0000";
	wait for ClockPeriod*15;
	V<="0110";
	wait for ClockPeriod*15;
	V<="0000";                             --One click Two key
  end process;
  
  
end tb;
