`timescale 1ns / 1ps

module RegisterModule
(
	input CLOCK,
	input [4:0] readAddress1, 	// Allows for read from two different addresses
	input [4:0] readAddress2,
	input [4:0] writeAddress, 	// Adrress to write to 
	input [63:0] writeData, 	// Data to be written 
	input regWrite, 			// Write enable
	output reg [63:0] regData1,	
	output reg [63:0] regData2
);

	reg [63:0] registerData[31:0];

	// Initial block initializes some of the registers 
	initial begin
		registerData[31] = 64'b0;
		registerData[1] = 64'd16;
		registerData[2] = 64'd12;
		registerData[3] = 64'd3;
		registerData[4] = 64'd4;
		registerData[5] = 64'd5;
		registerData[6] = 64'd6;
		registerData[7] = 64'd1;
	end
	
	// If regwrite is active, write the "writeData" to the register specified by 
	// "writeAddress" 
	always @(*) begin
		if (regWrite == 1) begin
			registerData[writeAddress] <= writeData;
		end
	end

	// Reads data from the register file based on the two addresses 
	always @(negedge CLOCK) begin
		regData1 <= registerData[readAddress1];
		regData2 <= registerData[readAddress2];
	end
endmodule
