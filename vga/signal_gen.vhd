----------------------------------------------------------------------------------
-- Company: KULeuven
-- Engineer: Mauro Verhoest
-- 
-- Create Date: 14.10.2022 08:55:49
-- Design Name: 
-- Module Name: signal_gen - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity signal_gen is
    Port ( clk_in : in STD_LOGIC;
           vsync : out STD_LOGIC;
           hsync : out STD_LOGIC;
           hpos,vpos : out positive range 1 to 1024; 
           blank : out STD_LOGIC);
end signal_gen;

architecture Behavioral of signal_gen is
signal x,y: integer range 0 to 1023:=0;
signal act_pxl_hrzntl, act_pxl_vrtcl : positive range 1 to 1024:=1;
signal hsync_sig : std_logic :='0';
signal Hactive,Vactive : std_logic :='0';

begin
hpos <= act_pxl_hrzntl;
vpos <= act_pxl_vrtcl; 
Hsync <= hsync_sig; 
blank <= not(Hactive and Vactive);


--generation of Horizontal signals 
horizontal_sync: process(clk_in)
begin   
if(rising_edge(clk_in)) then
    x<=x+1;
    
    
    if(x<96) then
        hsync_sig <= '0'; 
        Hactive <= '0';
    elsif(x>=96 and x<144) then
        hsync_sig <= '1';
        Hactive <= '0';    
    elsif(x>=144 and x<=784) then
        hsync_sig <= '1';
        Hactive <= '1';
        act_pxl_hrzntl <= act_pxl_hrzntl+1;
    elsif(x>=784 and x<800) then
        hsync_sig <= '1';
        Hactive <= '0';
    else
        hsync_sig <= '0';
        x <= 0;
        act_pxl_hrzntl <= 1;    
    

    end if;     
end if;
end process;



--Generation of Vertical signals 
vertical_sync: process(hsync_sig)
begin
    if(rising_edge(hsync_sig)) then
        y<=y+1;
        if(y<2) then
           Vsync <= '0';
           Vactive <= '0';
        elsif(y>=2 and y<35) then
            Vsync <= '1';
            Vactive <= '0';
        elsif(y>=35 and y<515) then
            Vsync <= '1';
            Vactive <= '1';
            act_pxl_vrtcl <= act_pxl_vrtcl +1;
        elsif(y>=515 and y<525) then
            Vsync <= '1';
            Vactive <= '0';
            

        else
            Vsync <= '0';
            y <= 0;
            act_pxl_vrtcl <= 1;
        end if; 
    end if;    
end process;
end Behavioral;
