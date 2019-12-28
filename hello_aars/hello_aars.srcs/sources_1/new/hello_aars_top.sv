`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2019 05:36:06 PM
// Design Name: 
// Module Name: hello_aars_top
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


module hello_aars_top #(
    parameter COUNT_WIDTH = 27
    )
    (
    input sys_clk,
    input sys_rst_n,
    output [5:0] leds
    );
    
    // --- Local variables ---
    reg [COUNT_WIDTH - 1:0] count;
    
    wire clk; 
    wire locked;
    
    // -- Clock instance ---
    clk_wiz_0 inst
    (
      // Clock out ports  
      .clk_out1(clk),
      // Status and control signals               
      .locked(locked),
      // Clock in ports
      .clk_in1(sys_clk)
    );
    
    // --- Functions ---
    always @ (posedge clk)
    begin : counter 
        if ( (sys_rst_n == 1'b0) || (count == ~0) )  begin
            count <= 0;
        end 
        else begin
            count <= count + 1;
        end        
    end

    // Assign counter to output
    assign leds[5:0] = count[COUNT_WIDTH-1:COUNT_WIDTH-1-5];
    //assign leds[4:0] = 5'b11111;
    
endmodule

