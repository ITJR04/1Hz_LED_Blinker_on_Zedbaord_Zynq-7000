# Clock Input: 100 MHz oscillator on ZedBoard
set_property PACKAGE_PIN Y9 [get_ports CLK]
set_property IOSTANDARD LVCMOS33 [get_ports CLK]

# Output to LED LD0
set_property PACKAGE_PIN T22 [get_ports led]
set_property IOSTANDARD LVCMOS33 [get_ports led]

# Reset Input from Switch (SW5)
set_property PACKAGE_PIN H18 [get_ports RESET]
set_property IOSTANDARD LVCMOS33 [get_ports RESET]
