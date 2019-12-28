`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2019 08:16:37 PM
// Design Name: 
// Module Name: joystick_top
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


module joystick_top(
    input i_clk,
    input i_rst_n,
    output [5:0] o_leds,
    input [9:0] js1,
    input [9:0] js2
    );

  // Registers
  wire clk;
  wire r_locked;
  
  reg [9:0] r_js_out;

  // Clock source
  clk_wiz_0 instance_name
   (
    // Clock out ports
    .clk_out1(clk),     // output clk_out1
    // Status and control signals
    .locked(r_locked),       // output locked
    // Clock in ports
    .clk_in1(i_clk)      // input clk_in1
   );
   
   // Push the Joystick input to the LED output
   always @(posedge clk) begin
        // Or the two joysticks so both can be tested
        r_js_out <= (js1 & js2);
   end
   
   // assign the outputs
   assign o_leds[0] = ~r_js_out[1];
   assign o_leds[1] = ~r_js_out[2];
   assign o_leds[2] = ~r_js_out[3];
   assign o_leds[3] = ~r_js_out[4];
   assign o_leds[4] = ~r_js_out[6];
   assign o_leds[5] = ~r_js_out[7];
   
endmodule
