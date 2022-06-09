`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2022 02:04:49 PM
// Design Name: 
// Module Name: regfile
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


module regfile(Aselect, Dselect, dbus, clk, Bselect, abus, bbus);
    input [31:0] Aselect, Bselect, Dselect, dbus;
    input clk;
    output wire [31:0] abus, bbus;
    
    zero_reg reg0(
        .Dselect(Dselect[0]),
        .Aselect(Aselect[0]),
        .Bselect(Bselect[0]),
        .abus(abus),
        .bbus(bbus),
        .D(32'h00000000)
    );
    
    register32 reg1(
        .clk(clk),
        .Dselect(Dselect[1]),
        .Aselect(Aselect[1]),
        .Bselect(Bselect[1]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
    
    register32 reg2(
        .clk(clk),
        .Dselect(Dselect[2]),
        .Aselect(Aselect[2]),
        .Bselect(Bselect[2]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
        
    
    register32 reg3(
        .clk(clk),
        .Dselect(Dselect[3]),
        .Aselect(Aselect[3]),
        .Bselect(Bselect[3]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
      
    
    register32 reg4(
        .clk(clk),
        .Dselect(Dselect[4]),
        .Aselect(Aselect[4]),
        .Bselect(Bselect[4]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
    
    register32 reg5(
        .clk(clk),
        .Dselect(Dselect[5]),
        .Aselect(Aselect[5]),
        .Bselect(Bselect[5]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
    
    register32 reg6(
        .clk(clk),
        .Dselect(Dselect[6]),
        .Aselect(Aselect[6]),
        .Bselect(Bselect[6]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
        
    
    register32 reg7(
        .clk(clk),
        .Dselect(Dselect[7]),
        .Aselect(Aselect[7]),
        .Bselect(Bselect[7]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
      
    
    register32 reg8(
        .clk(clk),
        .Dselect(Dselect[8]),
        .Aselect(Aselect[8]),
        .Bselect(Bselect[8]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
          
    register32 reg9(
        .clk(clk),
        .Dselect(Dselect[9]),
        .Aselect(Aselect[9]),
        .Bselect(Bselect[9]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
    
    register32 reg10(
        .clk(clk),
        .Dselect(Dselect[10]),
        .Aselect(Aselect[10]),
        .Bselect(Bselect[10]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
        
    
    register32 reg11(
        .clk(clk),
        .Dselect(Dselect[11]),
        .Aselect(Aselect[11]),
        .Bselect(Bselect[11]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
      
    
    register32 reg12(
        .clk(clk),
        .Dselect(Dselect[12]),
        .Aselect(Aselect[12]),
        .Bselect(Bselect[12]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
    
    register32 reg13(
        .clk(clk),
        .Dselect(Dselect[13]),
        .Aselect(Aselect[13]),
        .Bselect(Bselect[13]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
    
    register32 reg14(
        .clk(clk),
        .Dselect(Dselect[14]),
        .Aselect(Aselect[14]),
        .Bselect(Bselect[14]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
        
    
    register32 reg15(
        .clk(clk),
        .Dselect(Dselect[15]),
        .Aselect(Aselect[15]),
        .Bselect(Bselect[15]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
      
    
    register32 reg16(
        .clk(clk),
        .Dselect(Dselect[16]),
        .Aselect(Aselect[16]),
        .Bselect(Bselect[16]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
    
    register32 reg17(
        .clk(clk),
        .Dselect(Dselect[17]),
        .Aselect(Aselect[17]),
        .Bselect(Bselect[17]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
    
    register32 reg18(
        .clk(clk),
        .Dselect(Dselect[18]),
        .Aselect(Aselect[18]),
        .Bselect(Bselect[18]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
        
    
    register32 reg19(
        .clk(clk),
        .Dselect(Dselect[19]),
        .Aselect(Aselect[19]),
        .Bselect(Bselect[19]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
      
    
    register32 reg20(
        .clk(clk),
        .Dselect(Dselect[20]),
        .Aselect(Aselect[20]),
        .Bselect(Bselect[20]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
    
    register32 reg21(
        .clk(clk),
        .Dselect(Dselect[21]),
        .Aselect(Aselect[21]),
        .Bselect(Bselect[21]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
    
    register32 reg22(
        .clk(clk),
        .Dselect(Dselect[22]),
        .Aselect(Aselect[22]),
        .Bselect(Bselect[22]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
        
    
    register32 reg23(
        .clk(clk),
        .Dselect(Dselect[23]),
        .Aselect(Aselect[23]),
        .Bselect(Bselect[23]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
      
    
    register32 reg24(
        .clk(clk),
        .Dselect(Dselect[24]),
        .Aselect(Aselect[24]),
        .Bselect(Bselect[24]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
          
    register32 reg25(
        .clk(clk),
        .Dselect(Dselect[25]),
        .Aselect(Aselect[25]),
        .Bselect(Bselect[25]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
    
    register32 reg26(
        .clk(clk),
        .Dselect(Dselect[26]),
        .Aselect(Aselect[26]),
        .Bselect(Bselect[26]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
        
    
    register32 reg27(
        .clk(clk),
        .Dselect(Dselect[27]),
        .Aselect(Aselect[27]),
        .Bselect(Bselect[27]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
      
    
    register32 reg28(
        .clk(clk),
        .Dselect(Dselect[28]),
        .Aselect(Aselect[28]),
        .Bselect(Bselect[28]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
    
    register32 reg29(
        .clk(clk),
        .Dselect(Dselect[29]),
        .Aselect(Aselect[29]),
        .Bselect(Bselect[29]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
    
    register32 reg30(
        .clk(clk),
        .Dselect(Dselect[30]),
        .Aselect(Aselect[30]),
        .Bselect(Bselect[30]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
        
    
    register32 reg31(
        .clk(clk),
        .Dselect(Dselect[31]),
        .Aselect(Aselect[31]),
        .Bselect(Bselect[31]),
        .abus(abus),
        .bbus(bbus),
        .D(dbus)
    );
    
endmodule

