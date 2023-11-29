module Mux_four_to_one(input_1, input_2, input_3, input_4, select, mux_output);

	input [31:0] input_1, input_2, input_3, input_4;
	input [1:0] select;
	output [31:0] mux_output;

	assign mux_output = (select == 2'b00) ? input_1 :
			    (select == 2'b01) ? input_2 :
			    (select == 2'b10) ? input_3 :
			    (select == 2'b11) ? input_4 : 32'bx;
	// if select was 00 then input_1 goes on output
	// if select was 01 then input_2 goes on output
	// if select was 10 then input_3 goes on output
	// if select was 11 then input_4 goes on output

endmodule