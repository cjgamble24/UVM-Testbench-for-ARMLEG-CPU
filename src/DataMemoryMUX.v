module DataMemoryMUX
(
	input [63:0] readData,
	input [63:0] ALUresult,
	input memToReg,
	output reg [63:0] dataMemoryMUXout
);

	// Selects between the two data sources
	always @(*) case (memToReg)
		0: dataMemoryMUXout = ALUresult;
		1: dataMemoryMUXout = readData;
		default: dataMemoryMUXout = ALUresult;
	endcase
endmodule
