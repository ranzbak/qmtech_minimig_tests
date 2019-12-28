`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2019 02:03:06 PM
// Design Name: 
// Module Name: signal_gen
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

// This tone generator still has bugs
// The notes it produces are net dependent on the OUTPUT_FREQ parameter it seems :-|
// But since it tests the audio output of the board it's good enough for now.


module signal_gen
    #(
        parameter CLOCK_FREQ =  100000000,      // input 100MHz
        parameter OUTPUT_WIDTH = 16,            // 16-bit precision 
        parameter SAMPLE_RATE = 44100,          // The sample rate to use 44kHz
        parameter OUTPUT_FREQ = 2000            // Output 8kHz
    )
    (
        input clk,
        output [OUTPUT_WIDTH-1:0] o_dout,
        input i_rst_n
    );
    
    // Calculate some constants
    localparam P_MIDDLE = (2**OUTPUT_WIDTH)/2;
    localparam P_COUNT_BITS = $clog2(SAMPLE_RATE);
    localparam P_CLK_P_SAMP = CLOCK_FREQ/SAMPLE_RATE;
    localparam P_SAMP_P_FREQ = SAMPLE_RATE / OUTPUT_FREQ;
    
    localparam M2_PI = real(3.14159 * 2.0);
    
    // Registers
    reg [P_COUNT_BITS:0]   r_count = 0;
    reg [P_COUNT_BITS:0]   r_samp = 0;
    reg [P_COUNT_BITS:0]   r_pos = 0;
    reg [OUTPUT_WIDTH-1:0] r_output = 0;
    
    // Pre calculate table
    reg [OUTPUT_WIDTH-1:0] sin_tab [0:P_SAMP_P_FREQ];
    
    // Calculate the sample to output
    always @(posedge clk)
    begin
        r_count <= r_count + 1'b1;
        
        r_samp <= integer(r_count) / P_CLK_P_SAMP;
        r_pos <= r_samp % P_SAMP_P_FREQ;
       
        for (integer i = 0; i < P_SAMP_P_FREQ; i=i+1) begin
          if(r_pos == i)
            r_output = P_MIDDLE + $sin((real(i)*M2_PI)/real(P_SAMP_P_FREQ))*P_MIDDLE;
        end 
    end
    
    // Assign the output register to the output pin
    assign o_dout = r_output;
endmodule
