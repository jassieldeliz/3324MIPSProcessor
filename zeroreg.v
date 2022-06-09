`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2022 12:42:37 PM
// Design Name: 
// Module Name: zeroreg
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


module zeroreg(Dselect, D, Q);
    input [31:0] D;
    input Dselect;
    output [31:0] Q;
    
    assign Q = 32'b0;
endmodule

