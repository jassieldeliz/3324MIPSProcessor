`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Written by Jassiel Deliz
// Create Date: 05/23/2022 01:27:45 PM
// Design Name: 
// Module Name: decoder
// Project Name: 
// Description: General purpose instruction register decoder of the ibus input to the controller
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module decoder(
    input [4:0] r_in,
    output wire [31:0] r_out
    );
    assign r_out = 32'b1 << r_in;

endmodule
