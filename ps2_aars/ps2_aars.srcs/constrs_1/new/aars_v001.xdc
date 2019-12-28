# Clock oscillator
set_property PACKAGE_PIN N11 [get_ports i_clk]
set_property IOSTANDARD LVCMOS33 [get_ports i_clk]
# Reset button
set_property PACKAGE_PIN K5 [get_ports i_rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports i_rst_n]

# LEDs to blink on the board
set_property PACKAGE_PIN P5 [get_ports {o_leds[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_leds[0]}]
set_property PACKAGE_PIN T3 [get_ports {o_leds[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_leds[1]}]
set_property PACKAGE_PIN T2 [get_ports {o_leds[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_leds[2]}]
set_property PACKAGE_PIN R1 [get_ports {o_leds[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_leds[3]}]
set_property PACKAGE_PIN N4 [get_ports {o_leds[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_leds[4]}]
set_property PACKAGE_PIN P3 [get_ports {o_leds[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_leds[5]}]

# PS/2 ports
set_property PACKAGE_PIN P1 [get_ports i_ps2_clk]
set_property IOSTANDARD LVCMOS33 [get_ports i_ps2_clk]
set_property PACKAGE_PIN M1 [get_ports i_ps2_dat]
set_property IOSTANDARD LVCMOS33 [get_ports i_ps2_dat]