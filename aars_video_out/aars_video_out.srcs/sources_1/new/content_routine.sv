`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/02/2020 09:52:37 PM
// Design Name: 
// Module Name: content_routine
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


module content_routine(
    input clk,
    input [11:0] i_x_in,
    input [11:0] i_y_in,
    input        i_frame_in,
    input pix_enable,
    output [7:0] o_r_out,
    output [7:0] o_g_out,
    output [7:0] o_b_out
    );
    
    // Parameters
    parameter h_res = 1280;
    parameter v_res = 72;
    
    // Output registers
    reg [7:0] r_r_out = 0;
    reg [7:0] r_g_out = 0;
    reg [7:0] r_b_out = 0;
    
    // Frame counter
    reg [10:0] r_fcount = 0;
    
    // Just put out white all the time
    always @(posedge clk) begin
          if (i_frame_in == 1'b1) begin
            r_fcount = r_fcount + 1;
          end
    
        r_r_out <= 8'h00;
        r_g_out <= 8'h00;
        r_b_out <= 8'h00;
        case (r_fcount[9:8])
            2'b00: begin
                // Colored bars
                if (i_x_in <= (h_res/5)) begin
                    r_r_out <= 8'hFF;
                    r_g_out <= 8'hFF;
                    r_b_out <= 8'hFF;     
                end
                if (i_x_in <= ((h_res/5)*2) & i_x_in > (h_res/5) ) begin
                    r_r_out <= 8'hFF;
                    r_g_out <= 8'h00;
                    r_b_out <= 8'h00;     
                end
                if (i_x_in <= ((h_res/5)*3) & i_x_in > ((h_res/5)*2) ) begin
                    r_r_out <= 8'h00;
                    r_g_out <= 8'hFF;
                    r_b_out <= 8'h00;     
                end
                if (i_x_in <= ((h_res/5)*4) & i_x_in > ((h_res/5)*3) ) begin
                    r_r_out <= 8'h00;
                    r_g_out <= 8'h00;
                    r_b_out <= 8'hFF;     
                end
                if (i_x_in > ((h_res/5)*4) ) begin
                    r_r_out <= 8'h00;
                    r_g_out <= 8'h00;
                    r_b_out <= 8'h00;     
                end
            end
            2'b01: begin
                // Moving diamond patterns
                r_r_out <= i_x_in[7:0] + (i_y_in[7:0] + r_fcount[7:0]);
                r_g_out <= i_x_in[7:0] - i_y_in[7:0];
                r_b_out <= (i_x_in[8:1] + r_fcount[7:0]) + ~i_y_in[9:2];
            end
            2'b10: begin
                // Grid pattern with green diagonal lines
                if ((i_x_in[4:0] <= 1) | (i_y_in[4:0] <= 1)) begin
                    r_r_out <= 7'hFF;
                    r_g_out <= 7'hFF;
                    r_b_out <= 7'hFF;
                end
                if ((i_x_in[5:0] - i_y_in[5:0]) <= 1 | (i_x_in[5:0] - ~i_y_in[5:0]) <= 1) begin
                    r_r_out <= 7'h00;
                    r_g_out <= 7'hFF;
                    r_b_out <= 7'h00;
                end
            end
            2'b11: begin
                // Thick white lines on black backdrop
                if ((i_x_in[7:0] > 100) & (i_x_in[7:0] < 155)) begin
                    r_r_out <= 8'hFF;
                    r_g_out <= 8'hFF;
                    r_b_out <= 8'hFF;
                end
                if ((i_y_in[7:0] > 100) & (i_y_in[7:0] < 155)) begin
                    r_r_out <= 8'hFF;
                    r_g_out <= 8'hFF;
                    r_b_out <= 8'hFF;
                end
            end
        endcase
    end
    
    // Assign generated value to the output
    assign o_r_out = r_r_out;
    assign o_g_out = r_g_out;
    assign o_b_out = r_b_out;
endmodule
