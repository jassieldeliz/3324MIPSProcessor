`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/07/2022 11:26:37 AM
// Design Name: 
// Module Name: adder32
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


module adder32(
    input [31:0] a, b,
    output reg [31:0] out
    );
    
    always@(a, b) begin
        out = a + b;
    end
endmodule
