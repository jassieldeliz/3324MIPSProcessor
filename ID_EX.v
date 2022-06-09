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


module ID_EX(
    input [31:0] dselIn, signExt_in, abus_in, bbus_in,
    input imm_in, clk, Cin_in, storeValIn, loadValIn, setValIn,
    input [1:0] setValTypeIn,
    input [2:0] S_in,
    output [31:0] dSelOut, signExt_out, abus_out, bbus_out,
    output imm_out, Cin_out, storeValOut, loadValOut, setValOut,
    output [1:0] setValTypeOut,
    output [2:0] S_out
    );
    DFF32 muxVal(
        .DFFIN32(dselIn),
        .DFFOUT32(dSelOut),
        .clk(clk)
    );
     
    DFF32 signExtVal(
        .DFFIN32(signExt_in),
        .DFFOUT32(signExt_out),
        .clk(clk)
    );
    
    DFF32 Abus_val(
        .DFFIN32(abus_in),
        .DFFOUT32(abus_out),
        .clk(clk)
    );
    
    DFF32 Bbus_val(
        .DFFIN32(bbus_in),
        .DFFOUT32(bbus_out),
        .clk(clk)
    );
    
    DFF3 Sval(
        .DFFIN3(S_in),
        .DFFOUT3(S_out),
        .clk(clk)
    );
    
    DFF1 CinVal(
        .DFFIN1(Cin_in),
        .DFFOUT1(Cin_out),
        .clk(clk)
    );
    
    DFF1 immVal(
        .DFFIN1(imm_in),
        .DFFOUT1(imm_out),
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
    
    DFF2 setTypeVal(
        .DFFIN2(setValTypeIn),
        .DFFOUT2(setValTypeOut),
        .clk(clk)
    );
    
    DFF1 setVal(
        .DFFIN1(setValIn),
        .DFFOUT1(setValOut),
        .clk(clk)
    );



endmodule
