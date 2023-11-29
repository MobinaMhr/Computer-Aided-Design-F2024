module Activation_function(ac_in1, ac_in2, select, ac_out);	

	// Inputs: Two 32-bit operands and a selection signal
	input [31:0] ac_in1, ac_in2;
	input select;
	// Output: Result of the activation function, a 32-bit value
	output [31:0] ac_out;

	// Assign the output based on the value of the 'select' signal
	assign ac_out = (select) ? ac_in2 : ac_in1;
	// If 'select' is 1, then ac_out receives ac_in2; otherwise, ac_out receives ac_in1
	// In other words, if 'select' is 1, output ac_out is set to 32'b0 (ac_in2),
	// and if 'select' is 0, output ac_out is set to ac_in1
    
endmodule