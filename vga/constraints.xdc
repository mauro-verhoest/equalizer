#https://lauri.xn--vsandi-pxa.com/hdl/zynq/zybo-ov7670-to-vga.html -->listig 
#clock 125Mhz
set_property PACKAGE_PIN L16 [get_ports clk_125M]

set_property IOSTANDARD LVCMOS18 [get_ports clk_125M]
#horizontal and vertical sync
set_property PACKAGE_PIN P19 [get_ports hsync]
set_property PACKAGE_PIN R19 [get_ports vsync]

set_property IOSTANDARD LVCMOS18 [get_ports vsync]
set_property IOSTANDARD LVCMOS18 [get_ports hsync]

#REd channel vga output
set_property PACKAGE_PIN M19 [get_ports {vgaRed[0]}]
set_property PACKAGE_PIN L20 [get_ports {vgaRed[1]}]
set_property PACKAGE_PIN J20 [get_ports {vgaRed[2]}]
set_property PACKAGE_PIN G20 [get_ports {vgaRed[3]}]
set_property PACKAGE_PIN F19 [get_ports {vgaRed[4]}]

set_property IOSTANDARD LVCMOS18 [get_ports {vgaRed[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {vgaRed[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {vgaRed[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {vgaRed[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {vgaRed[4]}]

#green channel vga output
set_property PACKAGE_PIN H18 [get_ports {vgaGreen[0]}]
set_property PACKAGE_PIN N20 [get_ports {vgaGreen[1]}]
set_property PACKAGE_PIN L19 [get_ports {vgaGreen[2]}]
set_property PACKAGE_PIN J19 [get_ports {vgaGreen[3]}]
set_property PACKAGE_PIN H20 [get_ports {vgaGreen[4]}]
set_property PACKAGE_PIN F20 [get_ports {vgaGreen[5]}]

set_property IOSTANDARD LVCMOS18 [get_ports {vgaGreen[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {vgaGreen[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {vgaGreen[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {vgaGreen[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {vgaGreen[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {vgaGreen[5]}]



#blue channel vga output
set_property PACKAGE_PIN P20 [get_ports {vgaBlue[0]}]
set_property PACKAGE_PIN M20 [get_ports {vgaBlue[1]}]
set_property PACKAGE_PIN K19 [get_ports {vgaBlue[2]}]
set_property PACKAGE_PIN J18 [get_ports {vgaBlue[3]}]
set_property PACKAGE_PIN G19 [get_ports {vgaBlue[4]}]

set_property IOSTANDARD LVCMOS18 [get_ports {vgaBlue[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {vgaBlue[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {vgaBlue[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {vgaBlue[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {vgaBlue[4]}]

#create_clock -period 8.000 -name clk_125M -waveform {0.000 4.000} [get_ports -filter { NAME =~  "*" && DIRECTION == "IN" }]

#set_output_delay -clock [get_clocks clk_125M] -min 1.000 [get_ports -filter { NAME =~  "*" && DIRECTION == "OUT" }]
#set_output_delay -clock [get_clocks clk_125M] -max 2.000 [get_ports -filter { NAME =~  "*" && DIRECTION == "OUT" }]

#create_clock -period 40.000 -name clk25 -waveform {0.000 20.000} [get_nets clk_25M]
#create_clock -period 8.000 -name clk125 -waveform {0.000 4.000} [get_nets clk_125M]

#set_clock_latency -clock [list [get_clocks [list clk_125M [get_clocks -of_objects [get_pins u1/inst/mmcm_adv_inst/CLKOUT1]]]] [get_clocks -of_objects [get_pins u1/inst/mmcm_adv_inst/CLKOUT1]]] -source 1.000 [get_clocks clk_125M]
