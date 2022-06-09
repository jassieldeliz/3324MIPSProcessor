`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2022 02:37:55 PM
// Design Name: 
// Module Name: triStateBuffer32
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


module triStateBuffer32(
    input [31:0] Q,
    input select,
    output [31:0] bus
    );

    assign bus = select ? Q : 32'bz;
endmodule
