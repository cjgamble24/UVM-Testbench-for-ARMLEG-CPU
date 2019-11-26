`timescale 1ns / 1ps

module IFID
(
	input CLOCK,
	input [63:0] programCounter_in,
	input [31:0] CPUInstruction_in,
	output reg [63:0] programCounter_out,
	output reg [31:0] CPUInstruction_out
);

	always @(posedge CLOCK) begin
		programCounter_out <= programCounter_in;
		CPUInstruction_out <= CPUInstruction_in;
	end
endmodule