library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity keyboard_ev is
port(
  CLK  : in  std_logic;
    C  : in  std_logic_vector(3 downto 0);--supporting that there is only one signal
    O  : out std_logic_vector(3 downto 0);--give the transformation of the matrix keyboard in binary
D,erro : out std_logic;--inform the state of the curiut
    Q  : out std_logic_vector(3 downto 0)--to scan the keyboard
    );
end entity keyboard_ev;
architecture behavr of keyboard_ev is
type state_type is (s1,s2,s3,s4);
signal state:state_type;
begin
p1: process(CLK,C)
begin
if C=0 then
   if (CLK'event and CLK='1') then
          case state is
          when s1=> state<=s2;
          when s2=> state<=s3;
          when s3=> state<=s4;  
          when s4=> state<=s1; 
          end case;
   end if;
end if;
end process;
p2: process(state)
begin
case state is
when s1=> Q<="1000";
when s2=> Q<="0100";
when s3=> Q<="0010";  
when s4=> Q<="0001"; 
end case;
end process;
p3: process(C)
variable P : std_logic_vector(3 downto 0);
begin
if C>0 then
   if C="1000" then
      case state is
      when s1=> P :="0001";D<='1';erro<='0';
      when s2=> P :="0010";D<='1';erro<='0';
      when s3=> P :="0011";D<='1';erro<='0';
      when s4=> P :="0100";D<='1';erro<='0';
      end case;
   elsif C="0100" then
      case state is
      when s1=> P :="0101";D<='1';erro<='0';
      when s2=> P :="0110";D<='1';erro<='0';
      when s3=> P :="0111";D<='1';erro<='0';
      when s4=> P :="1000";D<='1';erro<='0';
      end case;
   elsif C="0010" then
      case state is
      when s1=> P :="1001";D<='1';erro<='0';
      when s2=> P :="1010";D<='1';erro<='0';
      when s3=> P :="1011";D<='1';erro<='0';
      when s4=> P :="1100";D<='1';erro<='0';
	  end case;
   elsif C="0001" then
	  case state is
	  when s1=> P :="0000";D<='1';erro<='0';
	  when s2=> P :="1101";D<='1';erro<='0';
	  when s3=> P :="1110";D<='1';erro<='0';
	  when s4=> P :="0000";D<='0';erro<='1';
	  end case; 
   end if;
   else P:="0000";D<='0';erro<='0';
end if;
O<=P;
end process;
end behavr;
