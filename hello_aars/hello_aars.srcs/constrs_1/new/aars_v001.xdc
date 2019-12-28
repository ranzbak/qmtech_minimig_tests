# Clock oscillator
set_property PACKAGE_PIN N11 [get_ports sys_clk]
set_property IOSTANDARD LVCMOS33 [get_ports sys_clk]
# Reset button
set_property PACKAGE_PIN K5 [get_ports sys_rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports sys_rst_n]

# LEDs to blink on the board
set_property PACKAGE_PIN P5 [get_ports {leds[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports leds[0]]
set_property PACKAGE_PIN T3 [get_ports {leds[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports leds[1]]
set_property PACKAGE_PIN T2 [get_ports {leds[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports leds[2]]
set_property PACKAGE_PIN R1 [get_ports {leds[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports leds[3]]
set_property PACKAGE_PIN N4 [get_ports {leds[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports leds[4]]
set_property PACKAGE_PIN P3 [get_ports {leds[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports leds[5]]