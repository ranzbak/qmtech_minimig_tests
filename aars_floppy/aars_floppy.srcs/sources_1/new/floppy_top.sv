`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/27/2019 11:49:41 PM
// Design Name: 
// Module Name: floppy_top
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


module floppy_top(
    input sys_clk,
    input sys_rst_n,
    output sys_led_n,
    // LEDS to show status
    output [5:0] o_leds,
    // Floppy IO pins
    inout exp_02,
    inout exp_04,
    inout exp_08,
    inout exp_10,
    inout exp_12,
    inout exp_16,
    inout exp_18,
    inout exp_20,
    inout exp_22,
    inout exp_24,
    inout exp_26,
    inout exp_28,
    inout exp_30,
    inout exp_32,
    inout exp_34,
    inout exp_35
    );
    
    // Parameters
    parameter BLINK_CYCLES = 50000000; // 50 milion cycles 1/2 second blink time
    
    // Clock signals 
    wire clk;
    wire locked;
    
    // Internal wires
    wire w_state;
    
    // wires between the in and output module

    // Output
    wire [5:0] leds_out;
    wire [5:0] leds_in;
    wire out_exp_02;
    wire out_exp_04;
    wire out_exp_08;
    wire out_exp_10;
    wire out_exp_12;
    wire out_exp_16;
    wire out_exp_18;
    wire out_exp_20;
    wire out_exp_22;
    wire out_exp_24;
    wire out_exp_26;
    wire out_exp_28;
    wire out_exp_30;
    wire out_exp_32;
    wire out_exp_34;
    wire out_exp_35;
    
    // Clock source
   clk_wiz_0 my_clk
   (
    // Clock out ports
    .clk_out1(clk),     // output clk_out1
    // Status and control signals
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(sys_clk));      // input clk_in1
    
    // Push on Push off module
    push_on_off my_push (
    .clk(clk),
    .i_push(sys_rst_n),
    .o_state(w_state)
    );
    assign sys_led_n = w_state;
    
    // Route output or input to in/out pins

        

    // Route the IO pins
    assign exp_02 = w_state ? out_exp_02 : 1'bZ;
    assign exp_04 = w_state ? out_exp_04 : 1'bZ;
    assign exp_08 = w_state ? out_exp_08 : 1'bZ;
    assign exp_10 = w_state ? out_exp_10 : 1'bZ;
    assign exp_12 = w_state ? out_exp_12 : 1'bZ;
    assign exp_16 = w_state ? out_exp_16 : 1'bZ;
    assign exp_18 = w_state ? out_exp_18 : 1'bZ;
    assign exp_20 = w_state ? out_exp_20 : 1'bZ;
    assign exp_22 = w_state ? out_exp_22 : 1'bZ;
    assign exp_24 = w_state ? out_exp_24 : 1'bZ;
    assign exp_26 = w_state ? out_exp_26 : 1'bZ;
    assign exp_28 = w_state ? out_exp_28 : 1'bZ;
    assign exp_30 = w_state ? out_exp_30 : 1'bZ;
    assign exp_32 = w_state ? out_exp_32 : 1'bZ;
    assign exp_34 = w_state ? out_exp_34 : 1'bZ;
    assign exp_35 = w_state ? out_exp_35 : 1'bZ;
    // Route the LEDS
    assign o_leds[5:0] = w_state ? leds_out[5:0] : leds_in[5:0];


    // Floppy input
    floppy_input my_output(
        .clk(clk),
        // LEDS to show status
        .o_leds(leds_in),
        // Floppy IO pins
        .exp_02(exp_02),
        .exp_04(exp_04),
        .exp_08(exp_08),
        .exp_10(exp_10),
        .exp_12(exp_12),
        .exp_16(exp_16),
        .exp_18(exp_18),
        .exp_20(exp_20),
        .exp_22(exp_22),
        .exp_24(exp_24),
        .exp_26(exp_26),
        .exp_28(exp_28),
        .exp_30(exp_30),
        .exp_32(exp_32),
        .exp_34(exp_34),
        .exp_35(exp_35)
    );
    
    // Floppy input
    floppy_output my_input(
        .clk(clk),
        // LEDS to show status
        .o_leds(leds_out),
        // Floppy IO pins
        .exp_02(out_exp_02),
        .exp_04(out_exp_04),
        .exp_08(out_exp_08),
        .exp_10(out_exp_10),
        .exp_12(out_exp_12),
        .exp_16(out_exp_16),
        .exp_18(out_exp_18),
        .exp_20(out_exp_20),
        .exp_22(out_exp_22),
        .exp_24(out_exp_24),
        .exp_26(out_exp_26),
        .exp_28(out_exp_28),
        .exp_30(out_exp_30),
        .exp_32(out_exp_32),
        .exp_34(out_exp_34),
        .exp_35(out_exp_35)
    );
    
endmodule

