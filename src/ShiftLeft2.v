module ShiftLeft2
(
	input [63:0] inputData,
	output reg [63:0] outputData
);

	always @(*) begin
		outputData = inputData << 2;
	end
endmodule