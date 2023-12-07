`timescale 1ns / 1ps
// Syncronous memory with read/write capabilities 

// Setup module and input and output ports 
module DataMemory
(
	input CLOCK,
	input [63:0] inputAddress, // Input for the memory addresses
	input [63:0] inputData, // Input for data to be written into memory 
	input memRead, // Indicated a read operation 
	input memWrite, // Write operation 
	output reg [63:0] outputData // Output for data that gets read from memory 
);

	// Defines memoryData array with 128 elements that are 64 bits wide
	reg [63:0] memoryData[127:0];

	// Initializes memory with some predefined values
	initial begin
		memoryData[0]  = 64'd0;
		memoryData[8]  = 64'd1;
		memoryData[16] = 64'd2;
		memoryData[24] = 64'd3;
		memoryData[32] = 64'd4;
		memoryData[40] = 64'd5;
		memoryData[48] = 64'd6;
		memoryData[56] = 64'd7;
		memoryData[64] = 64'd8;
		memoryData[72] = 64'd9;
		memoryData[80] = 64'd10;
		memoryData[88] = 64'd11;
		memoryData[96] = 64'd12;
	end

	// Memory Write when signal is given
	always @(posedge CLOCK) begin
		// Write "inputData" to memory location at "inputAddress"
		if (memWrite == 1) begin
			memoryData[inputAddress] <= inputData;
		end
	end

	// Memory Write when signal is given
	always @(negedge CLOCK) begin
		// Reads from memory at location "input Address" anmd assigns it to output
		if (memRead == 1) begin
			outputData <= memoryData[inputAddress];
		end
	end
endmodule