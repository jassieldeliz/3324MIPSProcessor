`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/06/2022 09:51:40 AM
// Design Name: 
// Module Name: cpu5
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


module cpu5(
    input reset,
    input clk,
    input [31:0] ibus,
    inout [31:0] databus,
    output [31:0] iaddrbus,
    output [31:0] daddrbus
    );
    
    wire
    IDimm, IDcin, IDstore, IDload, eqOut,
    IDset, IDeq, IDeqType, EXset, ALUZ2comp,
    ALUCOUT2comp;
    
    wire [1:0]
    IDsetType, EXsetType;
    
    wire [2:0]
    ID_S, EX_S;
    
    wire[31:0] 
    // IF stage wires
    IFpcplus4, branchMux2PC,
    // ID stage wires
    instrBus2Decoders, Aselect, Bselect, destReg,
    IDextended, IDdselect, IDabus2eq, IDbbus2eq, 
    pcplus4plusbranch, IDeqabus2idex, IDeqbbus2idex,
    IDpcplus4, lshifttwo2adder, Abus2idex, Bbus2idex,
    // EX stage wires
    EXabus, EXbbus, EXboperand, EXextended, EXimm, 
    EXcin, EXstore, EXload, EXdselect, EXdbus2comp,
    compDbus2exmem, compDbus2mux,
    // MEM stage wires
    MEMload, MEMstore, MEMdselect, MEMboperand,
    // WB stage wires
    WBdselect, WBdbus, WBload, WBdatabus, regdbus;

    ////////////////////////////////////
    //  BEGIN INSTRUCTION FETCH STAGE //
    ////////////////////////////////////

    PC_pipe PC(
        .branchIn(branchMux2PC),
        .val(iaddrbus),
        .clk(clk),
        .rst(reset)
    );
    
    adder32 PCplus4Adder(
        .a(32'd4),
        .b(iaddrbus),
        .out(IFpcplus4)
    );
    
    IF_ID ifid_pipeline(
        .clk(clk),
        .ibus(ibus),
        .instruction(instrBus2Decoders),
        .pcPlus4ValIn(IFpcplus4),
        .pcPlus4ValOut(IDpcplus4)
    );
    
    /////////////////////////////////////
    //  BEGIN INSTRUCTION DECODE STAGE //
    /////////////////////////////////////
    
    mux branchMux(
        .a(pcplus4plusbranch),
        .b(IFpcplus4),
        .sel(eqOut),
        .out(branchMux2PC)
    );
    
    leftShift2Module left2(
        .in(IDextended),
        .out(lshifttwo2adder)
    );
    
    adder32 branchAddrAdder(
        .a(lshifttwo2adder),
        .b(IDpcplus4),
        .out(pcplus4plusbranch)
    );

    equalityModule eqMod(
        .AvalIn(IDabus2eq),
        .BvalIn(IDbbus2eq),
        .AvalOut(IDeqabus2idex),
        .BvalOut(IDeqbbus2idex),
        .eq(IDeq),
        .eqType(IDeqType),
        .eqResult(eqOut),
        .clk(clk)
    );
    
    decoder rsDecoder(
        .r_in(instrBus2Decoders[26:21]),
        .r_out(Aselect)
    );
    
    decoder rtDecoder(
        .r_in(instrBus2Decoders[20:16]),
        .r_out(Bselect)
    );
    
    decoder rdDecoder(
        .r_in(instrBus2Decoders[15:11]),
        .r_out(destReg)
    );

    opcode_decoder opDecoder(
        .ibus_opcode(instrBus2Decoders[31:26]),
        .funct(instrBus2Decoders[5:0]),
        .imm(IDimm),
        .Cin(IDcin),
        .store(IDstore),
        .load(IDload),
        .S(ID_S),
        .set(IDset),
        .eq(IDeq),
        .eqType(IDeqType),
        .setType(IDsetType)
    );

    signExt sign_extender(
        .unex(instrBus2Decoders[15:0]),
        .ext(IDextended)
    );
    
    mux ID_Mux(
        .a(Bselect),
        .b(destReg),
        .sel(IDimm),
        .out(IDdselect)
    );
    
    regfile register_file(
        .Aselect(Aselect),
        .Bselect(Bselect),
        .Dselect(WBdselect),
        .abus(IDabus2eq),
        .bbus(IDbbus2eq),
        .dbus(regdbus),
        .clk(clk)
    );
    
    ///////////////////////////////////
    //  END INSTRUCTION DECODE STAGE //
    ///////////////////////////////////

    ID_EX idex_pipeline(
        .dselIn(IDdselect),
        .dSelOut(EXdselect),
        .abus_in(IDeqabus2idex),
        .abus_out(EXabus),
        .bbus_in(IDeqbbus2idex),
        .bbus_out(EXboperand),
        .signExt_in(IDextended),
        .signExt_out(EXextended),
        .imm_in(IDimm),
        .imm_out(EXimm),
        .Cin_in(IDcin),
        .Cin_out(EXcin),
        .S_in(ID_S),
        .S_out(EX_S),
        .storeValIn(IDstore),
        .storeValOut(EXstore),
        .loadValIn(IDload),
        .loadValOut(EXload),
        .setValIn(IDset),
        .setValOut(EXset),
        .setValTypeIn(IDsetType),
        .setValTypeOut(EXsetType),
        .clk(clk)
    );
    
    //////////////////////////
    //  BEGIN EXECUTE STAGE //
    //////////////////////////

    alu32 ALU(
        .a(EXabus),
        .b(EXbbus),
        .d(EXdbus2comp),
        .S(EX_S),
        .Cin(EXcin),
        .Z(ALUZ2comp),
        .Cout(ALUCOUT2comp)
    );
    
    mux EX_Mux(
        .a(EXextended),
        .b(EXboperand),
        .sel(EXimm),
        .out(EXbbus)
    );
    
    comparisonModule compMod(
        .compInput(EXdbus2comp),
        .compOut(compDbus2mux),
        .C(ALUCOUT2comp),
        .Z(ALUZ2comp),
        .setType(EXsetType)
    );
    
    mux compMux(
        .a(compDbus2mux),
        .b(EXdbus2comp),
        .sel(EXset),
        .out(compDbus2exmem)
    );
    
    //////////////////////////
    //   END EXECUTE STAGE  //
    //////////////////////////
    
    EX_MEM exmem_pipeline(
        .bOperandIn(EXboperand),
        .bOperandOut(MEMboperand),
        .dbusIn(compDbus2exmem),
        .dbusOut(daddrbus),
        .dSelIn(EXdselect),
        .dSelOut(MEMdselect),
        .storeValIn(EXstore),
        .storeValOut(MEMstore),
        .loadValIn(EXload),
        .loadValOut(MEMload),
        .clk(clk)
    );
    
    /////////////////////////////////
    //  BEGIN MEMORY ACCESS STAGE  //
    /////////////////////////////////
    
    triStateBuffer32 databusBuff(
        .Q(MEMboperand),
        .select(MEMstore),
        .bus(databus)
    );
    
    /////////////////////////////////
    //   END MEMORY ACCESS STAGE   //
    /////////////////////////////////
    
    MEM_WB memwb_pipeline(
        .dbusIn(daddrbus),
        .dbusOut(WBdbus),
        .databusIn(databus),
        .databusOut(WBdatabus),
        .DselIn(MEMdselect),
        .DselOut(WBdselect),
        .loadIn(MEMload),
        .loadOut(WBload),
        .storeIn(MEMstore),
        .clk(clk)
    );
    
    ////////////////////////////
    // BEGIN WRITE-BACK STAGE //
    ////////////////////////////
    
    mux WB_LoadMux(
        .a(WBdatabus),
        .b(WBdbus),
        .sel(WBload),
        .out(regdbus)
    );
    
    ////////////////////////////
    //  END WRITE-BACK STAGE  //
    ////////////////////////////
    
    
endmodule
