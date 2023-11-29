module Multiplier #(parameter N=32) (input1, input2, o_result);

    input [N-1:0]input1;
    input [N-1:0]input2;
    
    output reg [N-1:0] o_result;

    // Internal variables for mantissas, exponents, and signs
    reg [47:0] temp_mantis;
    reg [23:0] a_mantis, b_mantis;
    reg [22:0] res_mantis;
    reg [7:0] a_exp, b_exp, temp_exp, res_exp;
    reg a_sign, b_sign, res_sign;

    // Combinational logic to perform floating-point multiplication
    always @(*) begin
        // Extract mantissa, exponent, and sign from input1
        a_mantis = {1'b1,input1[22:0]};
        a_exp = input1[30:23];
        a_sign = input1[31];
        
        // Extract mantissa, exponent, and sign from input2
        b_mantis = {1'b1,input2[22:0]};
        b_exp = input2[30:23];
        b_sign = input2[31];

        // Calculate temporary exponent and mantissa
        temp_exp = a_exp + b_exp - 127;
        temp_mantis = a_mantis * b_mantis;

        // Extract result mantissa and adjust exponent based on overflow
        res_mantis = temp_mantis[47] ? temp_mantis[46:24] : temp_mantis[45:23];
        res_exp = temp_mantis[47] ? temp_exp + 1'b1 : temp_exp;

        // Determine the sign of the result
        res_sign = a_sign ^ b_sign; 

        // Set the output result based on input conditions
        o_result = (input1 == 32'b0 || input2 == 32'b0) ? 0 : {res_sign, res_exp, res_mantis};
    end

endmodule
