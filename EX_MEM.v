`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2022 10:08:00 AM
// Design Name: 
// Module Name: ID_EX
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


module EX_MEM(
    input [31:0] bOperandIn, dbusIn, dSelIn,
    input clk, storeValIn, loadValIn,
    output [31:0] bOperandOut, dbusOut, dSelOut,
    output storeValOut, loadValOut
    );
    
    DFF32 dselectVal(
        .DFFIN32(dSelIn),
        .DFFOUT32(dSelOut),
        .clk(clk)
    );
    
    DFF32 dbusVal(
        .DFFIN32(dbusIn),
        .DFFOUT32(dbusOut),
        .clk(clk)
    );
    
    DFF32 bOperandVal(
        .DFFIN32(bOperandIn),
        .DFFOUT32(bOperandOut),
        .clk(clk)
    );
    
    DFF1 storeVal(
        .DFFIN1(storeValIn),
        .DFFOUT1(storeValOut),
        .clk(clk)
    );
    
    DFF1 loadVal(
        .DFFIN1(loadValIn),
        .DFFOUT1(loadValOut),
        .clk(clk)
    );

endmodule