module Mux_two_to_one(input_1, input_2, select, mux_output);

	input [31:0] input_1, input_2;
	input select;
	output [31:0] mux_output;

	assign mux_output = (select) ? input_2 : input_1;
	// if select was 1 then input_2 goes on output
	// if select was 0 then input_1 goes on output

endmodule