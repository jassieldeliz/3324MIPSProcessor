`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2022 11:12:06 AM
// Design Name: 
// Module Name: DFF3
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


module DFF3(DFFIN3, DFFOUT3, clk);
    input [2:0] DFFIN3; 
    input clk;
    output reg [2:0] DFFOUT3;

    always @(posedge clk) begin
        DFFOUT3 = DFFIN3;
    end
endmodule
