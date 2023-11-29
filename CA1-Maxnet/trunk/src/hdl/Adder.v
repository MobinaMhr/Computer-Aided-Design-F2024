module Adder #(parameter N=32) (i_operand1, i_operand2, o_result);
    // Inputs: Two N-bit operands
    input [N-1:0]i_operand1;
    input [N-1:0]i_operand2;

    // Output: Result of the floating-point addition, N-bit
    output reg [N-1:0] o_result;

    // Internal variables for mantissas, exponents, signs, carry, and comparison result
    reg [23:0] mantissa_a, mantissa_b, temp_mantissa;
    reg [22:0] result_mantissa;
    reg [7:0] exponent_a, exponent_b, diff_exponent, result_exponent;
    reg sign_a, sign_b, result_sign, carry, comp;
    wire MSb;

    // Comparison of exponents and determination of mantissas, exponents, and signs
    always @(*) begin
        comp =  (i_operand1[30:23] > i_operand2[30:23])? 1'b1 : 
                (i_operand1[30:23] == i_operand2[30:23] && i_operand1[22:0] > i_operand2[22:0]) ? 1'b1 : 1'b0;
        
        mantissa_a  = comp ? {1'b1,i_operand1[22:0]} : {1'b1,i_operand2[22:0]};
        exponent_a = comp ? i_operand1[30:23] : i_operand2[30:23];
        sign_a  = comp ? i_operand1[31] : i_operand2[31];
        
        mantissa_b = comp ? {1'b1,i_operand2[22:0]} : {1'b1,i_operand1[22:0]};
        exponent_b = comp ? i_operand2[30:23] : i_operand1[30:23];
        sign_b  = comp ? i_operand2[31] : i_operand1[31];

        if (sign_a != sign_b && mantissa_a == mantissa_b && exponent_a == exponent_b)
            o_result = 32'b0;
        else
        begin
            diff_exponent = exponent_a - exponent_b;
            
            mantissa_b = (mantissa_b >> diff_exponent);
            
            // Addition or subtraction of mantissas based on sign comparison
            {carry, temp_mantissa} =  (sign_a  ~^ sign_b) ? (mantissa_a + mantissa_b) : (mantissa_a - mantissa_b); 
            
            result_exponent = exponent_a;

            // Handling the carry for normalization
            if(carry) begin
                temp_mantissa = temp_mantissa>>1;
                result_exponent = result_exponent+1'b1;
            end
            else begin
                // Normalization loop for denormalized numbers
                while(!temp_mantissa[23]) begin
                    temp_mantissa = temp_mantissa<<1;
                    result_exponent =  result_exponent-1'b1;
                end
            end

            // Final result assembly
            result_sign = sign_a; 
            result_mantissa = temp_mantissa[22:0];
            o_result = {result_sign, result_exponent, result_mantissa};
        end
    end
endmodule