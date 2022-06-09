`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/07/2022 11:27:28 AM
// Design Name: 
// Module Name: comparisonModule
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


module comparisonModule(
    input [31:0] compInput,
    output reg [31:0] compOut,
    input C, Z,
    input [1:0] setType
    );
    
    always@(C, Z, setType) begin
        case(setType)
            2'b00: begin        //SLT
                if(!C && !Z)
                    compOut[0] = 1;
                else
                    compOut = 32'b0;
            end         
//            2'b01: begin        //SGT -- Unused
//                if(C && !Z)
//                    compOut[0] = 1;
//                else
//                    compOut = 32'b0;
//            end
            2'b10: begin        //SLE
                if(!C || Z)
                    compOut[0] = 1;
                else
                    compOut = 32'b0;
            end
//            2'b11: begin        //SGE -- Unused
//                if(C || Z)
//                    compOut[0] = 1;
//                else
//                    compOut = 32'b0;
//            end
            default: compOut = compInput;
        endcase
    end
endmodule
