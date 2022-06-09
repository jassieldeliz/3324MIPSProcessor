`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2022 10:37:53 AM
// Design Name: 
// Module Name: MEM_WB
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


module MEM_WB(
    input [31:0] dbusIn, databusIn, DselIn,
    output [31:0] dbusOut, databusOut, 
    output reg [31:0] DselOut,
    input clk, loadIn, storeIn, 
    output loadOut, storeOut
    );
    
    always@(posedge clk) begin
        DselOut = storeIn ? 32'h00000001 : DselIn;
    end
    
    
    DFF32 daddrbusVal(
        .DFFIN32(dbusIn),
        .DFFOUT32(dbusOut),
        .clk(clk)
    );
    
    DFF32 databusVal(
        .DFFIN32(databusIn),
        .DFFOUT32(databusOut),
        .clk(clk)
    );
    
    DFF1 storeVal(
        .DFFIN1(storeIn),
        .DFFOUT1(storeOut),
        .clk(clk)
    );
    
    DFF1 loadVal(
        .DFFIN1(loadIn),
        .DFFOUT1(loadOut),
        .clk(clk)
    );
    
endmodule
