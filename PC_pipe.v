`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2022 11:48:18 AM
// Design Name: 
// Module Name: PC_pipe
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


module PC_pipe(
    input [31:0] branchIn,
    output reg [31:0] val,
    input clk, rst
    );
    
    always@(posedge clk) begin
        if(rst)
            val = 32'b0;
        else
            val = branchIn;
    end
    
endmodule
