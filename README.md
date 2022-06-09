# Multicycle Pipelined MIPS Processor

Hi there! This repo is the final result of a month-long endeavor to pipeline a single-cycle MIPS processor. This was done as a part of my computer architecture class, and encompasses a total of about 25 different hardware modules, all grouped together in the cpu5.v top file. This processor has support for 18 MIPS-style opcodes which are shown in the table below.

////-------PUT TABLE HERE DONT FORGET ------//////// 

Pictured below is the top level schematic of the processor. The CPU has a total of 5 pipeline stages, IF, ID, EX, MEM, and WB. These stages are separated by pipeline registers which contain D-flip-flops which hold values until the next rising edge of the clock. 

<img width="1268" alt="image" src="https://user-images.githubusercontent.com/25257062/172939838-b84968ba-bf53-4c6f-ae88-57a709e7e2a9.png">


# Design Modules

I'll try to go left to right here as best I can...

## The PC Pipeline

This module contains the acts as the first pipeline register. The only hardware contained within is a D-flip-flop which holds the calculated next instruction address. This address is calculated by a couple adders which I'll talk about later. It also includes a reset input to set the output of the register to 0. 

## The IF/ID Pipeline

The second of the pipeline registers. This register hold the incoming instruction bus (ibus) for a clock cycle.

## Decoders and Sign Extension

The set of five modules directly after the IF/ID pipeline are the instruction decoders. They parse the incoming 32 bit instruction bus into their R and I type parts as is standard in MIPS

![image](https://user-images.githubusercontent.com/25257062/172957718-6522c9d9-a170-4da2-8fb0-28dc19e7f672.png)

Each decoder is named for the section of the instruction bus it decodes. The rs, rt, and rd all work by using a bit-shift operation which shifts a 32'b1 value by the 5-bit binary value that was read into the module. As I'll explain more in depth in the register file section, the 32 registers in the reg file are selected by a 32 bit value, in which only one bit can be 1, hence the shifting of 32'b1. 

## Register File 

The register file is a 32x32 cache that holds values for quick processor access, and is structured as seen below. 

![image](https://user-images.githubusercontent.com/25257062/172958548-58213218-e48b-4f8b-a1e3-539c30ab4840.png)

Each of the 32 registers (apart from the zero register R0) is comprised of a negative-edge flip flop and two tri-state buffers. The output of register R0 is hardwired to ground in order to provide a constant 0 when needed. Any value written to R0 effectively results in it being discarded. To select a value in any given register, the correct Aselect and Bselect must be provided to the tri-state buffers. The tri-state buffers control whether or not the value gets placed onto the abus or bbus. As stated earlier, only one bit within the Aselect and Bselect lines is allowed to be 1, meaning that only one value is sent to the abus or bbus at any given time.

Given that the flip flops contained within the reg file are falling-edge sensitive, this allows the registers to read on the falling edge of the clock, thus saving time within the overall design. It is crucial that each stage fully procecces its instruction before the next rising edge, as that is the whole point of pipelining the processor. 

## The Immediate mux

I call it an immediate mux because I don't have a better name for it, but all it does is select between the rt and rd decoder outputs based on whether the instruction is an I-type or not. If the imm control signal from the opcode decoder is 1 (i.e., its an I-type) then it selects the destination register (Dselect) to be the same as the output of the rt decoder, otherwise it selects the actual decoded rd decoder value.

## The Equality Module

Last on the list in the ID stage is the equality module. This module provides support for the branching (BEQ and BNE) instructions. The important output of this module is a 1'b1 eqResult line which informs the branching hardware whether or not to branch. 

## The Branching Hardware

Above the IF and ID stages sits a collection of adders and muxes which complete support for address branching within the processor. The first adder within the IF stage adds 4 to the current instruction address. This is the standard increment for this processor. The other adder adds the branch address (which is the sign extended value shifted left 2 bits) and the aforementioned PC + 4 value to get the new address. The mux contained in this section then decides whether to use the PC + 4 value or the PC + 4 + branch value. 










