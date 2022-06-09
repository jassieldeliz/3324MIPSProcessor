`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////// 
// Created by Jassiel Deliz
// Create Date: 05/15/2022 12:08:26 PM
// Design Name: 
// Module Name: DFF32
// Project Name: Multi Cycle MIPS Processor
// Description: 32-bit D-Flop-Flop to be added as a buffer/register for the main pipelined ALU
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DFF32(DFFIN32, DFFOUT32, clk);
    input [31:0] DFFIN32;
    input clk;
    output reg [31:0] DFFOUT32;
     
    always @(posedge clk) begin
        DFFOUT32 = DFFIN32;
    end
endmodule
