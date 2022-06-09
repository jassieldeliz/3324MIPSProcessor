`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2022 12:41:00 PM
// Design Name: 
// Module Name: zero_reg
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


module zero_reg(D, Dselect, Aselect, Bselect, bbus, abus);

    input [31:0] D;
    input wire Dselect, Aselect, Bselect; 
    output [31:0] bbus, abus;
    
    wire [31:0] OUTQ2BUF;
    
    zeroreg RDFF(
        .Dselect(Dselect),
        .D(D),
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
