`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/27/2019 11:49:41 PM
// Design Name: 
// Module Name: push_on_off
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


module push_on_off(
    input clk,
    input i_push,
    output reg o_state
    );
    
    // Meta stability register
    reg r_push_meta;
    
    // Debounce counter
    parameter DB_CLKS = 10000000;
    reg r_db_push;
    
    // Handle meta stability 
    always @(posedge clk)
    begin
        r_push_meta <= i_push;
    end
    
    // Debounce the push button
    always @(posedge clk)
    begin
        reg [$clog2(DB_CLKS): 0] r_db_count; 
        reg r_prev_push = 0;
    
        // Debounce to 0
        r_db_push <= 1'b0;
    
        // Previous state
        r_prev_push <= r_push_meta;
    
        // Check if state changed
        if (r_prev_push == 1'b0 & r_push_meta == 1'b1 & r_db_count == '0) begin
            r_db_push <= 1'b1;
            r_db_count <= DB_CLKS;
        end
        
        // debounce count down
        if (r_db_count != '0) begin
            r_db_count <= r_db_count - 1;
        end  
    end
            
    // Invert the state at every push
    always @(posedge clk)
    begin
        // Invert at push event
        if (r_db_push == 1'b1) begin
           o_state <= ~o_state;
        end  
    end
    
endmodule
