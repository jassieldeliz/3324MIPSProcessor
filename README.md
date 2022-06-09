# Multicycle Pipelined MIPS Processor

Hi there! This repo is the final result of a month-long endeavor to pipeline a single-cycle MIPS processor. This was done as a part of my computer architecture class, and encompasses a total of about 25 different hardware modules, all grouped together in the cpu5.v top file. This processor has support for 18 MIPS-style opcodes which are shown in the table below.

////-------PUT TABLE HERE DONT FORGET ------//////// 

Pictured below is the top level schematic of the processor. The CPU has a total of 5 pipeline stages, IF, ID, EX, MEM, and WB. These stages are separated by pipeline registers which contain D-flip-flops which hold values until the next rising edge of the clock. 

<img width="1268" alt="image" src="https://user-images.githubusercontent.com/25257062/172939838-b84968ba-bf53-4c6f-ae88-57a709e7e2a9.png">


# Instruction Fetch Modules

## PC_Pipe.v

This module contains the acts as the first pipeline register. The only hardware contained within is a D-flip-flop which holds the calculated next instruction address. This address is calculated by a couple adders which I'll talk about later. It also includes a reset input to set the output of the register to 0. 

## adder32.v

Nothing fancy, just a simple 32 bit adder using the native verilog "+" operator. 

## 

