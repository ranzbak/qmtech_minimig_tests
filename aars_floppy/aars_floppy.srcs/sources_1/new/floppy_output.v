`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/27/2019 11:49:41 PM
// Design Name: 
// Module Name: floppy_output
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


module floppy_output(
    input clk,
    input sys_rst_n,
    // LEDS to show status
    output reg [5:0] o_leds,
    // Floppy IO pins
    output exp_02,
    output exp_04,
    output exp_08,
    output exp_10,
    output exp_12,
    output exp_16,
    output exp_18,
    output exp_20,
    output exp_22,
    output exp_24,
    output exp_26,
    output exp_28,
    output exp_30,
    output exp_32,
    output exp_34,
    output exp_35
    );
    
    parameter BLINK_CYCLES = 50000000; // Default 1/2 second
    
    // Counter for blink timing
    reg [$clog2(BLINK_CYCLES):0] r_count = BLINK_CYCLES;        
    // Output state
    reg r_blink = 0;
    
    
    always @(posedge clk)
    begin
       r_count <= r_count-1;
       if (r_count == 0)
       begin
            r_count <= BLINK_CYCLES;
            r_blink <= ~r_blink;
       end
       
       // LED output
       o_leds <= 6'b000000;
       if(r_blink == 1'b1) 
       begin
           o_leds <= 6'b111111;
       end;
    end
    
    // Output the blink to the IO pins
    assign exp_02 = r_blink;
    assign exp_04 = r_blink;
    assign exp_08 = r_blink;
    assign exp_10 = r_blink;
    assign exp_12 = r_blink;
    assign exp_16 = r_blink;
    assign exp_18 = r_blink;
    assign exp_20 = r_blink;
    assign exp_22 = r_blink;
    assign exp_24 = r_blink;
    assign exp_26 = r_blink;
    assign exp_28 = r_blink;
    assign exp_30 = r_blink;
    assign exp_32 = r_blink;
    assign exp_34 = r_blink;
    assign exp_35 = r_blink;
    
endmodule
