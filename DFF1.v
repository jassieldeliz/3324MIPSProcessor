`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2022 11:12:06 AM
// Design Name: 
// Module Name: DFF1
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


module DFF1(DFFIN1, DFFOUT1, clk);
    input DFFIN1, clk;
    output reg DFFOUT1;

    always @(posedge clk) begin
        DFFOUT1 = DFFIN1;
    end
endmodule
