LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;
USE IEEE.STD_LOGIC_ARITH.all;
---------------------------------------------------------
entity LZ_DSEG is
  port(
       clk,rst,sw1: in std_logic;
         seg: out bit_vector(7 downto 0);
         sel: out std_logic_vector(2 downto 0)
       );
end entity LZ_DSEG;
---------------------------------------------------------
architecture behave of LZ_DSEG is
  signal cnt: integer;
  signal co: std_logic;
  begin
    process(clk,rst) is
       begin
           if rst='0' then
            cnt<=0;
            co<='0';
            elsif clk' event and clk='1' then
            if  cnt=49999  then
            cnt<=0;
            co<='1';
            else
            cnt<=cnt+1;
            co<='0';
            end if;
        end if;
     end process;
     
     process(co,rst,sw1)
      variable i,n:integer:=0;
      begin
       if rst='0' then
         sel<="000";
         seg<="00111111";
         i:=0;
         n:=0;
         elsif co' event and co='1' then
  
       if sw1='1' then
         i:=i+1;
         if i=9 then
           i:=0;
         else 
         case i is
           when 1 => sel<="000"; seg<="01011011";
           when 2 => sel<="001"; seg<="01101111";
           when 3 => sel<="010"; seg<="01101111";
           when 4 => sel<="011"; seg<="01111101";
           when 5 => sel<="100"; seg<="00111111";
           when 6 => sel<="101"; seg<="01101101";
           when 7 => sel<="110"; seg<="01011011";
           when 8 => sel<="111"; seg<="00111111";
           when others =>sel<="000";
         end case;
       end if;
     else
      i:=0;
      n:=n+1;
      if n=9 then
       n:=0;
     else 
       case n is
         when 1 => sel<="000"; seg<="00000110";
         when 2 => sel<="001"; seg<="01011011";
         when 3 => sel<="010"; seg<="01001111";
         when 4 => sel<="011"; seg<="01100110";
         when 5 => sel<="100"; seg<="01101101";
         when 6 => sel<="101"; seg<="01111101";
         when 7 => sel<="110"; seg<="00000111";
         when 8 => sel<="111"; seg<="01111111";
         when others =>sel<="000";
       end case;
      end if;
    end if;
    end if;
    end process;
end behave;