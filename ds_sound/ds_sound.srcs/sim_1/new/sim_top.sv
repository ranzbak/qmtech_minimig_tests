`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/27/2019 12:55:31 AM
// Design Name: 
// Module Name: sim_top
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


module sim_top(
    output [15:0] o_dout
    );
    
  reg clk = 0;
  always #10 clk = ~clk;
  
  reg r_rst_n = 1; 
    
    
  // Signal generator
  signal_gen my_gen(
    .clk(clk),
    .o_dout(o_dout),
    .i_rst_n(r_rst_n)
    );
endmodule
