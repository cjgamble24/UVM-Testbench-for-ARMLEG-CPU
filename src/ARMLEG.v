`timescale 1ns / 1ps
`include "ProgramCounter.v"
`include "ProgramCounterMUX.v"
`include "Adder.v"
`include "InstructionMemory.v"
`include "ControlUnit.v"
`include "RegisterModule.v"
`include "SignExtend.v"
`include "ALUControl.v"
`include "ALU.v"
`include "ShiftLeft2.v"
`include "DataMemory.v"
`include "ALUMux.v"
`include "DataMemoryMUX.v"
`include "RegisterMux.v"
`include "IFID.v"
`include "IDEX.v"
`include "EXMEM.v"
`include "MEMWB.v"

module ARMLEG (
	input CLOCK,
	input RESET
);

	output [4:0] MEMWBwriteAddress;
	output MEMWBregWrite;
	
	output [63:0] adderResult;
	
	output [31:0] CPUInstruction;
	
	output reg2Loc;
	output ALUsrc;
	output memToReg;
	output regWrite;
	output memRead;
	output memWrite;
	output branch;
	output [1:0] ALUop;
	
	output [4:0] regMUX;
	
	output [63:0] regData1;
	output [63:0] regData2;
	  
	output [63:0] signExtendedResult;
	
	output [3:0] ALUoperation;
	  
	output [63:0] ALUmux;  
	
	output [63:0] ALUresult;
	output zeroFlag;
	
	output [63:0] shiftedResult;
	
	output [63:0] branchAddress; 
	
	output [63:0] readData;
	
	output [63:0] dataMemoryMUXresult;
	
	output [63:0] programCounter_in;
	output [63:0] programCounter_out;
	
	output [63:0] EXMEM_shiftedprogramCounter_out;			// Program Counter Mux
	output EXMEM_ALUzero;									// Program Counter Mux
	output EXMEM_isBranch; 					// M Stage		// Program Counter Mux
	
	ProgramCounter programCounter (CLOCK, RESET, programCounter_in, programCounter_out);
	
	Adder fourAdder (64'b0100, programCounter_out, adderResult);
	
	ProgramCounterMUX programCounterMUX(adderResult, EXMEM_shiftedprogramCounter_out, (EXMEM_isBranch&EXMEM_ALUzero), programCounter_in);
	
	InstructionMemory instructionMemory(programCounter_out, CPUInstruction);
	
	//IFID pipeline register
	output [63:0] IFID_ProgramCounter;
	output [31:0] IFID_CPUInstruction;
	
	ControlUnit controlUnit(CLOCK, CPUInstruction[31:21], reg2Loc, ALUsrc, memToReg, regWrite, memRead, memWrite, branch, ALUop);
	
	IFID IFID (CLOCK, programCounter_out, CPUInstruction, IFID_ProgramCounter, IFID_CPUInstruction);
	
	RegisterMux registerMUX(IFID_CPUInstruction[20:16], IFID_CPUInstruction[4:0], reg2Loc, regMUX);
	
	RegisterModule registerModule(IFID_CPUInstruction[9:5], regMUX, MEMWBwriteAddress, dataMemoryMUXresult, MEMWBregWrite, regData1, regData2);
	
	SignExtend signExtend(IFID_CPUInstruction, signExtendedResult);
	
	//IDEX pipeline register
	output [1:0] IDEX_ALUop; 				// EX Stage
	output IDEX_ALUsrc;		    			// EX Stage
	output IDEX_isBranch; 					// M Stage
	output IDEX_MemRead;		  			// M Stage
	output IDEX_MemWrite; 		  			// M Stage
	output IDEX_RegWrite;	  				// WB Stage
	output IDEX_MemToReg;					// WB Stage
	output [63:0] IDEX_ProgramCounter;
	output [63:0] IDEX_RegData1;
	output [63:0] IDEX_RegData2;
	output [63:0] IDEX_SignExtend;
	output [10:0] IDEX_ALUcontrol;
	output  [4:0] IDEX_WriteReg;
	
	IDEX IDEX(CLOCK, ALUop, ALUsrc, branch, memRead, memWrite, regWrite, memToReg, IFID_ProgramCounter, regData1, regData2, signExtendedResult, IFID_CPUInstruction[31:21], IFID_CPUInstruction[4:0], IDEX_ALUop, IDEX_ALUsrc, IDEX_isBranch, IDEX_MemRead, IDEX_MemWrite, IDEX_RegWrite, IDEX_MemToReg, IDEX_ProgramCounter, IDEX_RegData1, IDEX_RegData2, IDEX_SignExtend, IDEX_ALUcontrol, IDEX_WriteReg);
	
	ALUControl ALUcontrol(IDEX_ALUop, IDEX_ALUcontrol, ALUoperation);
	
	ALUMux ALUMUX(IDEX_RegData2, IDEX_SignExtend, IDEX_ALUsrc, ALUmux);
	
	ALU ALU(IDEX_RegData1, ALUmux, ALUoperation, ALUresult, zeroFlag);
	
	ShiftLeft2 shiftLeft2(IDEX_SignExtend, shiftedResult);
	
	Adder branchAdder(IDEX_ProgramCounter, shiftedResult,  branchAddress);
	
	//EXMEM pipeline register
	output EXMEM_MemRead; 				// M Stage
	output EXMEM_MemWrite; 				// M Stage
	output EXMEM_RegWrite;				// WB Stage
	output EXMEM_MemToReg;				// WB Stage
	output [63:0] EXMEM_InputAddress;
	output [63:0] EXMEM_InputData;				
	output [4:0] EXMEM_WriteReg;
	
	EXMEM EXMEM(CLOCK, IDEX_isBranch, IDEX_MemRead, IDEX_MemWrite, IDEX_RegWrite, IDEX_MemToReg, branchAddress, zeroFlag, ALUresult, IDEX_RegData2, IDEX_WriteReg, EXMEM_isBranch, EXMEM_MemRead, EXMEM_MemWrite, EXMEM_RegWrite, EXMEM_MemToReg, EXMEM_shiftedprogramCounter_out, EXMEM_ALUzero, EXMEM_InputAddress, EXMEM_InputData, EXMEM_WriteReg);
	
	DataMemory dataMemory(EXMEM_InputAddress, EXMEM_InputData, EXMEM_MemRead, EXMEM_MemWrite, readData);
	
	//MEMWB Pipeline Register
	output [63:0] MEMWB_Address;
	output [63:0] MEMWB_ReadData;
	output MEMWB_MemToReg;
	
	MEMWB MEMWB(CLOCK, EXMEM_InputAddress, readData, EXMEM_WriteReg, EXMEM_RegWrite, EXMEM_MemToReg, MEMWB_Address, MEMWB_ReadData, MEMWBwriteAddress, MEMWBregWrite, MEMWB_MemToReg);
	
	DataMemoryMUX dataMemoryMUX(MEMWB_ReadData, MEMWB_Address, MEMWB_MemToReg, dataMemoryMUXresult);

endmodule


