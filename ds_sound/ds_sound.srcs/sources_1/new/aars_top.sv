`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2019 01:28:43 AM
// Design Name: 
// Module Name: aars_top
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


module aars_top(
    input i_clk,
    input i_rst_n,
    output o_ds_l,
    output o_ds_r,
    output [5:0] o_leds
    );
    
  // clock wire
  wire clk;
  wire locked;
  
  // Internal reset handling
  reg r_rst_n;
  
  // DAC in/output
  reg [15:0] r_din;
  wire w_ds_out;

  // Clock value
  clk_wiz_0 instance_name
   (
    // Clock out ports
    .clk_out1(clk),        // output clk_out1
    // Status and control signals
    .locked(locked),       // output locked
    // Clock in ports
    .clk_in1(i_clk)        // input clk_in1
    );   
    
  // Internal Reset handling
  assign r_rst_n = (i_rst_n == 1 & locked == 1);
    
  // Debug ALI, to check functioning of the module
  ila_0 my_ila (
	.clk(clk), // input wire clk

	.probe0(r_rst_n), // input wire [0:0]  probe0  
	.probe1(r_din), // input wire [15:0]  probe1 
	.probe2(o_ds_l), // input wire [0:0]  probe2 
	.probe3(o_ds_r) // input wire [0:0]  probe3
);
   

  // Signal generator
  signal_gen my_gen(
    .clk(clk),
    .o_dout(r_din),
    .i_rst_n(r_rst_n)
    );


  // Delta Sigma DAC
  dac_dsm2 my_dac
  (
    .din(r_din),
    .dout(w_ds_out),
    .clk(clk),
    .n_rst(r_rst_n)
    );
  
  // set LEDS
  assign o_leds = '0;
    
  // output to left and right
  assign o_ds_l = w_ds_out;
  assign o_ds_r = w_ds_out; 

endmodule
