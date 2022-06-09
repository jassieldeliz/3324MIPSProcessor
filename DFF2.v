`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2022 10:18:50 AM
// Design Name: 
// Module Name: DFF2
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


module DFF2(
    input [1:0] DFFIN2,
    input clk,
    output reg [1:0] DFFOUT2
    );
    always @(posedge clk) begin
        DFFOUT2 = DFFIN2;
    end
endmodule
