----------------------------------------------------------------------------------
-- Company: KULeuven
-- Engineer: Bsc. Mauro Verhoest
-- 
-- Create Date: 16.10.2022 19:59:00
-- Design Name: 
-- Module Name: top - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;


entity top is 

generic(
    d_width : integer := 5;
    d_width_green_top : integer := 6
    
);


Port(clk_125M : in std_logic;
    hsync,vsync : out std_logic;
    vgaRed,vgaBlue : out std_logic_vector(d_width-1 downto 0);
    vgaGreen : out std_logic_vector(d_width_green_top-1 downto 0));
end top;

architecture logic_flow of top is 
    signal clk_25M : std_logic;
    signal clk_125MHz : std_logic;
    signal blank : std_logic :='0';
    signal hpos,vpos : positive range 1 to 1024;
    signal s_size_1,s_size_2,s_size_3 : std_logic_vector(9 downto 0);


COMPONENT vio_0
  PORT (
    clk : IN STD_LOGIC;
    probe_out0 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    probe_out1 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    probe_out2 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
  );
END COMPONENT;
    component signal_gen is 


        Port ( clk_in : in STD_LOGIC;
           vsync : out STD_LOGIC;
           hsync : out STD_LOGIC;
           hpos,vpos : out positive range 1 to 1024; 
           blank : out STD_LOGIC);
    end component; 

    component vga_bars is
        generic( d_width : integer := 5;
    d_width_green : integer :=6
); 


        port(clk: in std_logic;
        blank_in : in std_logic;
        hpos,vpos : in positive range 1 to 1024;
        size_1,size_2,size_3 : in positive range 1 to 1024; 
        vga_red,vga_blue : out std_logic_vector(d_width-1 downto 0);
        vga_green : out std_logic_vector(d_width_green-1 downto 0));
    end component;

    component clk_wiz_0
port
 (-- Clock in ports
  -- Clock out ports
  clk_out1          : out    std_logic;
  clk_out2          : out    std_logic;
  clk_in1           : in     std_logic
 );



end component;
    begin

   u1 : clk_wiz_0
   port map ( 
  -- Clock out ports  
   clk_out1 => clk_125Mhz,
   clk_out2 => clk_25M,
   -- Clock in ports
   clk_in1 => clk_125M
 );
    u2: signal_gen port map(
    clk_in => clk_25M,
    blank => blank,
    hsync => hsync,
    vsync => vsync,
    hpos => hpos,
    vpos => vpos);
    
    virtual_probe : vio_0
  PORT MAP (
    clk => clk_25M,
    probe_out0 => s_size_1,
    probe_out1 => s_size_2,
    probe_out2 => s_size_3
   
    
  );

    u3: vga_bars port map(
    clk => clk_25M,
    blank_in => blank,
    size_1 => TO_INTEGER(signed(s_size_1)),
    size_2 => TO_INTEGER(signed(s_size_2)),
    size_3 => TO_INTEGER(signed(s_size_3)),
    hpos => hpos,
    vpos => vpos,
    vga_red => vgaRed,
    vga_green => vgaGreen,
    vga_blue => vgaBlue
    );
end logic_flow;