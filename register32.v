`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2022 02:06:19 PM
// Design Name: 
// Module Name: register32
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 32-bit register cell to be used in the larger 32x32 regfile module
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module register32(D, clk, Dselect, Aselect, Bselect, bbus, abus);

    input wire clk, Dselect, Aselect, Bselect;
    input [31:0] D;
    output [31:0] bbus, abus;
    
    wire [31:0] OUTQ2BUF;
       
    
    neg_DFF32 RDFF(
        .Dselect(Dselect),
        .D(D),
        .clk(clk),
        .Q(OUTQ2BUF)
    );
    
    triStateBuffer32 bufA(
        .select(Aselect),
        .Q(OUTQ2BUF),
        .bus(abus)
    );
    
    triStateBuffer32 bufB(
        .select(Bselect),
        .Q(OUTQ2BUF),
        .bus(bbus)
    );
    


endmodule
