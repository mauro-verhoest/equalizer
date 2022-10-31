----------------------------------------------------------------------------------
-- Company: KULeuven
-- Engineer: Bsc. Mauro Verhoest
-- 
-- Create Date: 14.10.2022 08:55:49
-- Design Name: 
-- Module Name: vga_bars- Behavioral
-- Project Name: equaliZer
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity vga_bars is 

generic( d_width : integer := 5;
    d_width_green : integer :=6
); 

port(clk: in std_logic;
    blank_in : in std_logic;
    hpos,vpos : in positive range 1 to 1024;
    vga_red,vga_blue : out std_logic_vector(d_width-1 downto 0);
    size_1,size_2,size_3 : in positive range 1 to 1024; 
    vga_green : out std_logic_vector(d_width_green-1 downto 0));
end vga_bars;


architecture logic_flow of vga_bars is 
    --signal size : positive range 1 to 1024:=100;
    signal obj_X_pos: positive range 1  to 1024:=200;
    signal obj_Y_pos: positive range 1 to 1024:=400;
    signal s_size_1 : positive range 1 to 1024;
    signal s_size_2 : positive range 1 to 1024;
    signal s_size_3 : positive range 1 to 1024;
    signal h_size: positive  range 1 to 1024:=30;--make bar
    signal h_size_1 : positive range 1 to 1024:=1;




    signal h_origin_first_bar : positive range 1 to 1024:=200;
    signal h_origin_second_bar : positive range 1 to 1024:=320;
    signal h_origin_thrid_bar : positive range 1 to 1024:=440;
    signal bar_1_height : positive  range 1 to 1024;
    signal bar_2_height : positive range 1 to 1024;
    signal bar_3_height : positive range 1 to 1024;
    signal h_height : positive  range 1 to 1024 :=480; 
begin 
    square_draw : process(clk)
    begin
        if(rising_edge(clk)) then
            if(blank_in='0') then
            --Draw your shape here
            --synchronise sizes 
            s_size_1 <= size_1;
            s_size_2 <= size_2;
            s_size_3 <= size_3;

            
            
            --calculate height bars 
            bar_1_height <= h_height-s_size_1;
            bar_2_height <= h_height-s_size_2;
            bar_3_height <= h_height-s_size_3;

            --first bar green 
            if((h_origin_first_bar<=hpos) and
            (hpos<=h_origin_first_bar+h_size) and 
            (bar_1_height <= hpos) and 
            (hpos <= h_height)) then 
                vga_red <= std_logic_vector(TO_SIGNED(0,d_width));
                vga_green <= std_logic_vector(TO_SIGNED(63,d_width_green));
                vga_blue <= std_logic_vector(TO_SIGNED(0,d_width));
            --second bar red 
            elsif((h_origin_second_bar<=hpos) and
            (hpos<=h_origin_second_bar+h_size) and 
            (bar_2_height <= hpos) and 
            (hpos <= h_height)) then 
                vga_red <= std_logic_vector(TO_SIGNED(31,d_width));
                vga_green <= std_logic_vector(TO_SIGNED(0,d_width_green));
                vga_blue <= std_logic_vector(TO_SIGNED(0,d_width));
           --third bar blue 
           elsif((h_origin_thrid_bar<=hpos) and
            (hpos<=h_origin_thrid_bar+h_size) and 
            (bar_3_height <= hpos) and 
            (hpos <= h_height)) then 
                vga_red <= std_logic_vector(TO_SIGNED(0,d_width));
                vga_green <= std_logic_vector(TO_SIGNED(0,d_width_green));
                vga_blue <= std_logic_vector(TO_SIGNED(31,d_width));
            else 
                ---leave rest of screen white for testing 
                vga_red <= std_logic_vector(TO_SIGNED(31,d_width));
                vga_green <= std_logic_vector(TO_SIGNED(63,d_width_green));
                vga_blue <= std_logic_vector(TO_SIGNED(31,d_width));
            
                --leave black in production 
                --vga_red <= std_logic_vector(TO_SIGNED(0,d_width));
                --vga_green <= std_logic_vector(TO_SIGNED(0,d_width_green));
                --vga_blue <= std_logic_vector(TO_SIGNED(0,d_width));

            end if;
            else
            vga_red <= std_logic_vector(TO_SIGNED(0,d_width));
            vga_green <= std_logic_vector(TO_SIGNED(0,d_width_green));
            vga_blue <= std_logic_vector(TO_SIGNED(0,d_width)); 

           
--            if((0<=hpos+h_size-obj_X_pos) and
--            (obj_X_pos+h_size_1-hpos>=0) and
--            (0<=vpos+s_size-obj_Y_pos)and 
--            (obj_Y_pos +s_size-vpos >=0)) then
--                vga_red <= std_logic_vector(TO_SIGNED(0,d_width));
--                vga_green <= std_logic_vector(TO_SIGNED(63,d_width_green));
--                vga_blue <= std_logic_vector(TO_SIGNED(0,d_width));
--            else
--                vga_red <= std_logic_vector(TO_SIGNED(31,d_width));
--                vga_green <= std_logic_vector(TO_SIGNED(63,d_width_green));
--                vga_blue <= std_logic_vector(TO_SIGNED(31,d_width));

--            end if;
--            else 
--                vga_red <= std_logic_vector(TO_SIGNED(0,d_width));
--                vga_green <= std_logic_vector(TO_SIGNED(0,d_width_green));
--                vga_blue <= std_logic_vector(TO_SIGNED(0,d_width));
                
--            end if;
            
        end if;
        end if; 
    end process;
end logic_flow;


