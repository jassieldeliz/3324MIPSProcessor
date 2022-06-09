`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2022 10:56:00 AM
// Design Name: 
// Module Name: opcode_decoder
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


module opcode_decoder(
    input [5:0] ibus_opcode, funct,
    output reg imm, Cin, store, load, set, eq, eqType,
    output reg [2:0] S,
    output reg [1:0] setType
    );

    
    
    always@(ibus_opcode || funct) begin
        store = 1'b0;
        load  = 1'b0;
        set   = 1'b0;
        eq    = 1'b0;
        setType = 2'bx;
        case(ibus_opcode)
            6'b000000:      //R-type operations covered by nested case statement
            begin
                case(funct)
                6'b000011:      //ADD OPERATION
                    begin
                    S = 3'b010; 
                    Cin = 0; 
                    imm = 1'b0;
                end
                6'b000010:      //SUB OPERATION
                    begin
                        S = 3'b011;
                        Cin = 1;
                        imm = 1'b0;
                    end
                6'b000001:      //XOR OPERATION
                    begin
                        S = 3'b000;
                        Cin = 0;
                        imm = 1'b0;
                    end
                6'b000111:      //AND OPERATION
                    begin
                        S = 3'b110;
                        Cin = 0;
                        imm = 1'b0;
                    end
                6'b000100:      //OR OPERATION
                    begin
                        S = 3'b100;
                        Cin = 0;
                        imm = 1'b0;
                    end
                6'b110110:      //SLT OPERATION
                    begin
                        S = 3'b011;
                        Cin = 1;
                        imm = 1'b0;
                        set = 1'b1;
                        setType = 2'b00;
                    end
                6'b110111:      //SLE OPERATION
                    begin
                        S = 3'b011;
                        Cin = 1;
                        imm = 1'b0;
                        set = 1'b1;
                        setType = 2'b10;
                    end
                endcase
                
            end
            6'b000011:      //ADDI OPERATION
                begin
                    S = 3'b010; 
                    Cin = 0; 
                    imm = 1'b1;
                end
            6'b000010:      //SUBI OPERATION
                begin
                    S = 3'b011;
                    Cin = 1;
                    imm = 1'b1;
                end
            6'b000001:      //XORI OPERATION
                begin
                    S = 3'b000;
                    Cin = 0;
                    imm = 1'b1;
                end
            6'b001111:      //ANDI OPERATION
                begin
                    S = 3'b110;
                    Cin = 0;
                    imm = 1'b1;
                end
            6'b001100:      //ORI OPERATION
                begin
                    S = 3'b100;
                    Cin = 0;
                    imm = 1'b1;
                end
            6'b011110:      //LOAD WORD (LW) OPERATION
                begin
                    S = 3'b010;
                    Cin = 0;
                    imm = 1'b1;
                    load = 1'b1;
                end
            6'b011111:      //STORE WORD (SW) OPERATION
                begin
                    S = 3'b010;
                    Cin = 0;
                    imm = 1'b1;
                    store = 1'b1;
                end
            6'b110000:      //BEQ OPERATION
                begin
                    store = 1'b1;
                    eq = 1'b1;
                    eqType = 1'b0;
                end
            6'b110001:      //BNE OPERATION
                begin
                    store = 1'b1;
                    eq = 1'b1;
                    eqType = 1'b1;
                end
        endcase
    end
endmodule
