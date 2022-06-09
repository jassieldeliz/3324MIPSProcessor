`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/07/2022 11:27:28 AM
// Design Name: 
// Module Name: equalityModule
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


module equalityModule(
    input [31:0] AvalIn, BvalIn,
    output reg [31:0] AvalOut, BvalOut,
    input eq, eqType, clk,
    output reg eqResult
    );
    
    always@(AvalIn, BvalIn, clk, eq, eqType) begin
        if(eq == 1'b1)
            case(eqType)
                1'b0: begin         //BEQ
                    if(AvalIn == BvalIn)
                        eqResult = 1'b1;
                end
                1'b1: begin         //BNE
                    if(AvalIn != BvalIn)
                        eqResult = 1'b1;
                end
            endcase
        else begin
            AvalOut = AvalIn;       //values pass through module unmodified if not performing either BNE or BEQ
            BvalOut = BvalIn;
            eqResult = 1'b0;
        end    
    end
    
    
endmodule
