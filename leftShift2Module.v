`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/07/2022 12:44:40 PM
// Design Name: 
// Module Name: leftShift2Module
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


module leftShift2Module(
    input [31:0] in,
    output reg [31:0] out
    );
    
    always@(in) begin
        out = in << 2;
    end
endmodule
