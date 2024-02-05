module Multiplier(inp_one, inp_two, up_8_bits);

    input [7:0] inp_one;
    input [7:0] inp_two;
    output [7:0] up_8_bits;

    reg [15:0] mul_result;
    assign mul_result = inp_one * inp_two;
    assign up_8_bits = mul_result[15:8];

endmodule