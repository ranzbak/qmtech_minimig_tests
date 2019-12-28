`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/27/2019 11:49:41 PM
// Design Name: 
// Module Name: floppy_input
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


module floppy_input(
    input clk,
    // LEDS to show status
    output [5:0] o_leds,
    // Floppy IO pins
    input exp_02,
    input exp_04,
    input exp_08,
    input exp_10,
    input exp_12,
    input exp_16,
    input exp_18,
    input exp_20,
    input exp_22,
    input exp_24,
    input exp_26,
    input exp_28,
    input exp_30,
    input exp_32,
    input exp_34,
    input exp_35
    );
    
    // Route the input to the 
    assign o_leds[0] = exp_02;
    assign o_leds[1] = exp_04;
    assign o_leds[2] = exp_08;
    assign o_leds[3] = exp_10;
    assign o_leds[4] = exp_12;
    assign o_leds[5] = exp_16 & exp_18 & exp_20 & exp_22 & exp_24 & exp_26 & exp_28 & exp_30 & exp_32 & exp_34 & exp_35;
endmodule
