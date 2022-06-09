`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2022 02:25:07 PM
// Design Name: 
// Module Name: signExt
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


module signExt(
    input [15:0] unex,
    output reg [31:0] ext
    );
    
    always @(unex) begin
        ext <= $signed(unex);
    end
endmodule
