`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2022 10:08:00 AM
// Design Name: 
// Module Name: IF_ID
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


module IF_ID(
    input [31:0] ibus, pcPlus4ValIn,
    input clk,
    output [31:0] instruction, pcPlus4ValOut
    );
    DFF32 instrBusVal(
        .DFFIN32(ibus),
        .DFFOUT32(instruction),
        .clk(clk)
    );
    DFF32 pcPlus4Val(
        .DFFIN32(pcPlus4ValIn),
        .DFFOUT32(pcPlus4ValOut),
        .clk(clk)
    );
    

endmodule