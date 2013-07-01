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
    C  : in  std_logic_vector(3 downto 0);--supporting that there is only one signal
    O  : out std_logic_vector(3 downto 0);--give the transformation of the matrix keyboard in binary
	D,erro : out std_logic;--inform the state of the curiut
    Q  : out std_logic_vector(3 downto 0)--to scan the keyboard
    );
  end component;
--测试用的信号和参数  
  
  signal C,O,Q:std_logic_vector(3 downto 0);
  signal CLK,D,erro:std_logic;
  constant ClockPeriod:time:=2 ns;
--验证用的相关说明，将被测信息打印出来，可以去掉，直接观察波形！  
  file so:text;
begin


  c_divider:keyboard_ev port map (clk=>clk,C=>C,O=>O,D=>D,erro=>erro,Q=>Q);
  
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
    C<="0001";
	wait for ClockPeriod*15;
	C<="0000";
	wait for ClockPeriod*15;
	C<="0010";
	wait for ClockPeriod*15;
	C<="0000";
	wait for ClockPeriod*15;
	C<="0100";
	wait for ClockPeriod*15;
	C<="0000";
	wait for ClockPeriod*15;
	C<="1000";
	wait for ClockPeriod*15;
	C<="0000";
	wait for ClockPeriod*15;
  end process;
  
  
end tb;