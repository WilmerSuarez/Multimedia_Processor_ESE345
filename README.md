## Multimedia Processor

### Table of Contents

- [Introduction](#introduction)
- [Design Process](#design-process)
	- [Program Counter and Instruction Buffer](#program-counter-and-instruction-buffer)
	- [Pipeline Registers](#pipeline-registers)
	- [Instruction Decoder and Control Unit](#instruction-decoder-and-control-unit)
	- [Register File](#register-file)
	- [ALU 1 & 2 and Load Immediate Shifter](#alu-1-and-alu-2-and-load-immediate-shifter)
- [Test Conditions](#test-conditions)
	- [](#)

## Introduction 
###### Multimedia Unit Block Diagram
![alt text](https://i.imgur.com/lksLEB2.jpg "Multimedia Unit Block Diagram")

The processor, is a 3-stage pipelined multimedia unit used for Single-Instruction
Multiple-Data (SIMD) instructions. 

## Design Process

###### Program Counter and Instruction Buffer
![alt text](https://i.imgur.com/T5jsywh.png "Program Counter and Instruction Buffer")

The program counter is used to track execution of the program by indexing into the 
instruction buffer. The counter is held at zero when the Reset signal is asserted. When it
is not asserted, the counter increments on the rising edge of every clock cycle.

The instruction buffer is a buffer consisting of 32 24-bit entries. It outputs the 
instruction at the specified PC on the rising edge of every clock cycle. As the instruction 
buffer has 32 entries, the program counter is log2(32) or 5 bits wide. Once the program
counter reaches 31, it rolls over to 0 again.

These two units combined form the first stage of the pipeline.   

###### Pipeline Registers
![alt text](https://i.imgur.com/KEwNitP.png "Pipeline Registers")

The pipeline registers, IF/ID (Instruction Fetch/Instruction Decode) and ID/EX&WB 
(Instruction Decode/Execution & Write Back), are used to separate the 3-stages of the 
processor. The registers are clock edge-sensitive (positive edge) to allow one instruction 
to be processed at every stage, and one instruction to be completed every cycle (after the 
initial 3 cycles). 

This 3-stage design to ignores the need to fix Data Hazards (instructions needing 
data before it is ready). By the time an Instruction is decoded (in the second stage), the 
data that it might need is already calculated by the third stage. Structural Hazards (
attempting to use the same resource simultaneously by two instructions) only occur with the 
Register file; when an instruction is trying to read a register while another is trying to 
write to the same register. This hazard is resolved by writing to the Register File on the 
rising edge of the clock first and then reading from it at the falling edge of the clock; 
allowing the more recent instruction to receive the most up-to-date data. Lastly, Control 
Hazards (attempting to make decisions before a condition is evaluated) do not occur in this 
design because there are no branching instructions.

The first register receives instructions from the instruction buffer in the Instruction 
Fetch (IF) Stage and outputs an instruction after every positive edge of the clock. The 
instruction output is sent to the Decoder in the Instruction Decode (ID) Stage. The second 
register receives input from the Decoder, the Control Unit, and the Register File. From the 
Register File, it receives three 64-bit signals of the data from the three selected 
registers. From the Decoder, it receives the instruction opcodes and the associated signals 
needed for those instructions. From the Control Unit, it receives the 2-bit Result Select 
signal needed to select which output from the EX stage will be written back to the Register 
File, and the Register Write Enable. 

###### Instruction Decoder and Control Unit
![alt text](https://i.imgur.com/s2fkwbt.png "Instruction Decoder and Control Unit")

The Decoder (in the Instruction Decode (ID) Stage), receives an instruction from the ID/IF 
pipeline register. The Decoder generates a subset of signals from the instruction received
to use as input for the Register File, Control, and IF/EX&WB Register. 

The Control Unit receives the Instruction signal (unchanged) from the Decoder and outputs 3 
signals. The first signal, S3_Select, is used when the instruction is a Load Immediate. This
signal is sent to a multiplexer that is between the Decoder and the Register File that 
selects which Register File address input RS3 will receive. This is used to send the data of
the writeback register to the Load Immediate Shifter (to preserve the data) in the EX&WB 
stage. The second signal, Result_Select, is used to select witch result from the EX&WB stage
will be written back to the Register File. The last signal, Reg_Write_Enable, is used to 
allow data to be written to the Register File. The Control Unit only prevents data to be 
written during a NOP instruction.

###### Register File
![alt text](https://i.imgur.com/VFQlFaU.png "Register File")

The register file contains the 32 64-bit registers available to the processor. It is able  
to read 3 registers and write 1 register each cycle. The register specified via the Write 
Register signal is written to with the contents of the Data In signal when the Write Enable 
signal is asserted during the rising edge of a clock cycle. The registers specified in Read 
Register S1, Read Register S2, Read Register S3 are read to their associated Data signals 
during the falling edge of a clock cycle. The file also implements data forwarding in which 
it determines when a register that is being read is also being written to, and forwards the
new value of the register, thus resolving potential data hazards.

The S3 Select Mux is used to determine which register is read as S3. This is used for Load 
Immediate instructions, to maintain the untouched bits in the destination register.

The S3 Select Mux is controlled using the S3 Select signal, which is generated by the 
Control Unit. All the inputs for reading registers are provided by the Instruction Decoder, 
while all the write related signals are connected to the output of the final stage of the 
pipeline. 

###### ALU 1 and ALU 2 and Load Immediate Shifter
![alt text](https://i.imgur.com/EjAV6k0.png "ALU 1, 2 and Load Immediate Shifter")

The EX&WB stage is the last stage of the pipelined design. This stage computes the values that will be 
written to the register file. The stage is composed of 2 ALUs and a separate module for the Load 
Immediate Instruction. The signals coming into this stage all come from the ID/EX&WB Register.

The first ALU is used to compute the R3-format instructions. This ALU only uses the first 2 of the 
three register data outputs from the pipeline register. The two other inputs to this module are the RS2 
Immediate signal (used by the Shift Left Halfword Immediate instruction), and the opcode. The second 
ALU is used to compute the R4-format Instructions. These instructions are all SIMD instructions that 
receive all 3 register data outputs from the pipeline register. The only other signal is the opcode. 
The third module is the Load Immediate Shifter that computes the one R-1 format instruction (Load 
Immediate). The module receives the data of the register that will be written (used for preservation) 
and the 16-bit immediate with its offset. The output of all these modules are sent to a multiplexer 
that selects, using the result select signal from the Control Unit, the result that will be written 
back to the Register File. 

## Test Conditions 

###### Instruction Buffer

