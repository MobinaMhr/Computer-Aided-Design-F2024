module Mac(clk, rst, reg_en, clean_reg, window, filter, result);

    input clk, rst, reg_en, clean_reg;
    input [7:0] window, filter;
    output [7:0] result;

    wire [7:0] mul_res;
    wire [11:0] sum_result, reg_result;

    Multiplier multiplier(.inp_one(window), .inp_two(filter), .up_8_bits(mul_res));
    
    Adder #(12) adder(.inp_one({{4'd0}, mul_res}), .inp_two(reg_result), .result(sum_result));

    Register #(12) partial_result(.inp(sum_result), .load_en(reg_en), .clk(clk), .rst(rst|clean_reg), .outp(reg_result));

    assign result = reg_result[11:4];

endmodule