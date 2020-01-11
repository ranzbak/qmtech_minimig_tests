`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/02/2020 06:22:06 PM
// Design Name: 
// Module Name: aars_video_top
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


module aars_video_top(
    input sys_clk,
    input sys_rst_n,
    output reg [5:0] leds,
    output reg o_hsync,
    output reg o_vsync,
    output o_adv_de,
    output o_adv_clk,
    output [7:0] o_r,
    output [7:0] o_g,
    output [7:0] o_b
    );
    
    // Core signals
    wire clk;
    wire locked;
    
    // Video interconnects
    
    // Generated RGB values
    wire [7:0] w_r;
    wire [7:0] w_g;
    wire [7:0] w_b;
    
    // Current video postion
    wire [11:0] w_x;
    wire [11:0] w_y;
    wire        w_frame;
    
    // enable to indicate the next data point is needed
    reg r_adv_de;
    reg r_adv_clk;
    assign o_adv_de = r_adv_de;
    assign o_adv_clk = r_adv_clk;
    
    // delay loop
    parameter C_DELAY = 148000000/2;
    reg [$clog2(C_DELAY):0] count = C_DELAY;
    
    // Debugging Logical analyzer
    ila_0 your_instance_name (
        .clk(clk), // input wire clk
    
    
        .probe0(o_adv_de), // input wire [0:0]  probe0  
        .probe1(o_adv_clk), // input wire [0:0]  probe1 
        .probe2(r_adv_de), // input wire [0:0]  probe2 
        .probe3(r_adv_clk) // input wire [0:0]  probe3
    );
    
    // Clock generation IP
    clk_wiz_0 instance_name
    (
       // Clock out ports
       .clk_out1(clk),     // output clk_out1
       // Status and control signals
       .resetn(sys_rst_n), // input resetn
       .locked(locked),       // output locked
       // Clock in ports
       .clk_in1(sys_clk));      // input clk_in1
    
    always @(posedge clk) begin
        count <= count - 1;
        if (count == '0) begin
            count <= C_DELAY;
            leds <= ~leds;
        end
    end
    
    // Generate test display data
    content_routine my_routine(
        .clk(clk),
        .i_x_in(w_x),
        .i_y_in(w_y),
        .i_frame_in(w_frame),
        .pix_enable(),
        .o_r_out(w_r),
        .o_g_out(w_g),
        .o_b_out(w_b)
    );
    
    // Convert the generated output data into video out signals
    signal_generator mygen(
        .clk(clk),
        .o_hsync(o_hsync),
        .o_vsync(o_vsync),
        .i_r(w_r),
        .i_g(w_g),
        .i_b(w_b),
        .o_x(w_x),
        .o_y(w_y),
        .o_frame(w_frame),
        .o_r(o_r),
        .o_g(o_g),
        .o_b(o_b),
        .o_adv_clk(r_adv_clk),
        .o_adv_en(r_adv_de)
    );

endmodule
