`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2022 02:42:56 PM
// Design Name: 
// Module Name: neg_DFF32
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


module neg_DFF32(Dselect, clk, D, Q);
    input [31:0] D;
    input clk, Dselect;
    output reg [31:0] Q;

//    assign newclk = clk & Dselect;
//        always @(negedge newclk) begin
//            Q = D;
//    end    
    
    
    always @(negedge clk) begin
        if (Dselect==1'b1)  Q = D;
    end
endmodule
