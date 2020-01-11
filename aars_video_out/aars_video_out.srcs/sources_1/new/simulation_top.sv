`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/03/2020 10:45:26 PM
// Design Name: 
// Module Name: simulation_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module simulation_top(

    );
    reg clk = 0;
    
    // Generate clock
    always #5 clk = ~clk;
    
    // Output registers 
    reg [7:0] r_r = 0;
    reg [7:0] r_g = 0;
    reg [7:0] r_b = 0;
    reg r_hsync = 1'b0;
    reg r_vsync = 1'b0;
    reg r_adv_de = 1'b0;
    reg r_adv_clk = 1'b0;
    
    // Leds
    reg [5:0] r_leds = 0;
    
    // Instatiate module
    aars_video_top aars_sym_top (
    .sys_clk(clk),
    .sys_rst_n(1'b1),
    .leds(r_leds),
    .o_hsync(r_hsync),
    .o_vsync(r_vsync),
    .o_adv_de(r_adv_de),
    .o_adv_clk(r_adv_clk),
    .o_r(r_r),
    .o_g(r_g),
    .o_b(r_b)
    );
endmodule
