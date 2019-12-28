`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/13/2019 11:08:21 PM
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

//`define DEBUG

module aars_top(
    input i_clk,
    input i_ps2_clk,
    input i_ps2_dat,
    input i_rst_n,
    output reg [5:0] o_leds
);

    // Local variables
    reg clk;
    wire locked;
    
    // Reset signal
    reg r_rst_n;
    
    // PS2 decoded signal
    wire       w_strobe;
    reg [7:0]  ps2_byte;
    reg [23:0] r_strobe_count = 0;
    reg [7:0]  r_out_byte;
    reg        r_clear;
    
    // Meta stability registers
    reg r_ps2_clk;
    reg r_ps2_dat;
    
    // Keep reset signal high until Clock source is locked
    assign r_rst_n = i_rst_n & locked;
    
    // Clock
    clk_wiz_0 inst_clk
    (
        // Clock out ports  
        .clk_out1(clk),
        // Status and control signals               
        .locked(locked),
        
        // Clock in ports
        .clk_in1(i_clk)
    );
    
    // PS2 decoder, meta stability code
    // Adding two registers (flip-flops) back to back provides enough protection
    always @ (posedge clk) begin
        r_ps2_clk <= i_ps2_clk;
        r_ps2_dat <= i_ps2_dat;
    end
    
    // Count down on the keyboard strobe, so it's visible to the human eye
    always @(posedge clk) begin
        if (w_strobe == 1'b1)
        begin
            // Reset clear bit
            r_clear <= 1'b0;
            
            // When a key is released
            if (r_out_byte == 8'hF0)
            begin
                // Out byte is all 1's making sure the LEDS are off
                r_out_byte <= '1;
                // Set clear to signal ignore of the next byte received
                //r_clear <= 1'b1;
            end
            // when key is pressed
            else
            begin
                // Ignore code that comes after clear
                if (r_clear == 1'b0)
                begin
                    // PS2 received byte to the record received
                    r_out_byte <= ps2_byte;
                end
            end
        end        
        
        // Handle reset
        if (r_rst_n == 1'b0) 
        begin
            //r_strobe_count <= '0;
            r_out_byte <= '1;
            r_clear <= 1'b0;
        end
    end
    
    // r_out_byte to the debug LEDS
    assign o_leds = r_out_byte[5:0];
    
    
`ifdef DEBUG
    // ILA in circuit debugger, 
    ila_0 debugger (
        .clk(clk), // input wire clk
    
        .probe0(i_ps2_clk), // input wire [0:0]  probe0  
        .probe1(i_ps2_dat), // input wire [0:0]  probe1 
        .probe2(w_strobe), // input wire [0:0]  probe2
        .probe3(o_leds), // input wire [5:0] probe3
        .probe4(i_rst_n) // input wire [0:0] probe4 
    );
`endif
    
    // PS2 protocol decoder to key stroke bytes    
    aars_ps2 ps2_decoder (
        .i_clk(clk),
        .i_ps2_clk(r_ps2_clk),
        .i_ps2_dat(r_ps2_dat),
        .o_byte_strobe(w_strobe),
        .o_byte(ps2_byte)
    );
    
endmodule
