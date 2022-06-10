# Multicycle Pipelined MIPS Processor

Hi there! This repo is the final result of a month-long endeavor to pipeline a single-cycle MIPS processor. This was done as a part of my computer architecture class, and encompasses a total of about 25 different hardware modules, all grouped together in the cpu5.v top file. This processor has support for 18 MIPS-style opcodes which are shown in the table below.

////-------PUT TABLE HERE DONT FORGET ------//////// 

Pictured below is the top level schematic of the processor. The CPU has a total of 5 pipeline stages, IF, ID, EX, MEM, and WB. These stages are separated by pipeline registers which contain D-flip-flops which hold values until the next rising edge of the clock. 

<img width="1268" alt="image" src="https://user-images.githubusercontent.com/25257062/172939838-b84968ba-bf53-4c6f-ae88-57a709e7e2a9.png">


# Design Modules

I'll try to go left to right here in a somewhat organized fashion...

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

## The ID/EX Pipeline

The third of the pipeline registers. This pipeline register holds all of the values generated in the ID stage, including all control signals, as well as the sign-extended immediate value, the values of the ALU inputs, and the destination register select. 

## The B-Operand Mux

This mux's job is to select between the b-operand given by the regfile and the sign extended immediate value. Similar to the immediate mux from the ID stage, it selects the immediate value if the instruction is an I-type, and the b-operand otherwise. 

## The Arithmetic Logic Unit

Everyone's favorite module, the ALU performs all of the main processor instruction calculations. It supports a total of 8 operations as seen below, with one of them being a "dont care" operation, which just means that we don't care what the output of the ALU is. 

![image](https://user-images.githubusercontent.com/25257062/172971535-232f0e50-3ece-4379-b1fc-ea05b8b4e556.png)

Pictured here is the top diagram for the ALU. Do note that a "Z" output for the zero detector is included in the code, but is not shown here. 

![image](https://user-images.githubusercontent.com/25257062/172971725-f7f22bca-4aa0-4ac3-9758-92485cf8ad59.png)

As mentioned earlier, all of the modules within each stage must process the given instruction as fast as possible, before the next rising edge of the clock so as to not fall behind. Typical 32-bit parallel adders like the one seen below are fairly inneficient in terms of time, and take too long to do what we needed it to do. 

![image](https://user-images.githubusercontent.com/25257062/172972005-c1b3263c-7ceb-4e3c-9f3b-3223732aa099.png)

In the worst case, the signal must travel through all 32 adder cells, which causes significant slowdown when compared to the faster and more efficient adder implementation, the **look ahead carry adder**. As such, we decided to create our own implementation. While Vivado's "+" operator would've given us the same thing, we wanted to reuse the circuitry for our other operations, such as subtract, in order to speed those up as well. 

We first began by creating a couple new variables and rewriting some of the logic equations

For the full adder modules, we rewrote them to be:

c[i+1] = (a[i] & b[i]) | ((a[i] | b[i]) & c[i]) = g[i] | (p[i] & c[i]) 

where,

g[i] = a[i] & b[i]   // carry generate 
p[i] = a[i] ^ b[i]   // carry propagate 

The usage of the exclusive or gates in the carry propagate gives the same truth table as the normal carry out. When this is all drawn out, we get the following for our carry chain.

![image](https://user-images.githubusercontent.com/25257062/172973058-4c29d7b5-a747-45f7-9fde-055207506770.png)

Which in turn when combined with our full adder modules from earlier yield:

![image](https://user-images.githubusercontent.com/25257062/172973097-7b2ab91e-f93f-4cb7-b412-73bcf63f085e.png)

As a result of this, the worst case delay is now no longer through the adder carry chain, and a relatively simple behavioral model can be written: 

module add_cell (d, g, p, a, b, c); //this is contained within alu32.v
  output d, g, p; 
  input a, b, c; 

  assign g = a & b; 
  assign p = a ^ b; 
  assign d = p ^ c; 
endmodule 

While this is a step in the right direction, the synthesizer will still spend too much time attempting to optimize 32 levels of AND and OR gates in its quest to find a combination that yields the smallest worst case delay. As such, we used a combination of structural and behavioral modules, which more specifically tell the synthesizer what to do and make its life easier.

Since the carry chain is still linear, there is still a fairly significant delay through it, on the order of O(N). While not initially a huge deal, we can make it better. Here is where the fun begins. When our number of bits is greater than 8, it's oftentimes more efficient to use the look ahead carry (LAC) implementation. More specifically, implementing the LAC technique in a binary tree as shown below:

![image](https://user-images.githubusercontent.com/25257062/172974320-3230a3e8-44f3-4325-83e5-e1affffd818b.png)

Where each LAC circuit is the following:

![image](https://user-images.githubusercontent.com/25257062/172975943-50f6edb0-7ae6-47ca-b1ef-daa2bd9846d2.png)

For a 32 bit adder such as ours, there are 5 rows of LACS, each with half as many modules as the one before (layer 1 has 16, 2 has 8, etc.)

With this implementation, the worst case delay begins with the a and b inputs, and propagates through the tree down to the root, and then back up the tree to the outputs. With a worst case scenario of only propagating through 9 LACs instead of 32, our runtime suddenly becomes significantly more efficient, on the order of O(log N)

With this setup, it's much easier for the synthesizer to decide which gates will best optimize the design. 

Since we have written out the LAC chain and adders ourselves, we can now modify it to perform the other operations within the ALU. Subtraction, for exmample, is a - b, or a + (-b). Knowing this, we know that for subtraction we need to invert the b bits and add one i.e., two's complement. Thus, our carry in will be 1. With all of this information, we can modify our circuit to be as follows:

![image](https://user-images.githubusercontent.com/25257062/172981554-90dfcb4c-f4d1-458f-9efc-ddb1590b9d99.png)

Somewhat similarly, we can add a little more circuitry to make this work with our logical operations. All we have to do is disable the carry chain. This is accomplished by forcing the carry in for each bit to 0. This is implemented by adding AND gates as seen below:

![image](https://user-images.githubusercontent.com/25257062/172982436-ac8e3afb-e260-4f20-9c74-629f07a52638.png)

Finally, we also added an overflow module to the ALU to detect...well...overflow. Obviously, a carry out of 1 after the MSB indicates an unsigned overflow. For signed numbers, we can XOR the carry out and the 31st bit to detect if we have signed overflow. This module is implemented as seen below.

![image](https://user-images.githubusercontent.com/25257062/172982793-efc8b981-59e9-4475-97f8-69ec3317e859.png)







