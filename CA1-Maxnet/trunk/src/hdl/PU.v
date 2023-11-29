module Pu(input1, input2, input3, input4, weight1, weight2, weight3, weight4, clk, rst, o_result);

    input [31:0] input1, input2, input3, input4;
    input [31:0] weight1, weight2, weight3, weight4;
    input clk, rst;
    output [31:0] o_result;

    wire [31:0] w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11;

    Multiplier M1(.input1(input1), .input2(weight1), .o_result(w1));
    Multiplier M2(.input1(input2), .input2(weight2), .o_result(w2));
    Multiplier M3(.input1(input3), .input2(weight3), .o_result(w3));
    Multiplier M4(.input1(input4), .input2(weight4), .o_result(w4));

    Register32_w R1(.input_data(w1), .clock(clk), .reset(rst), .output_data(w5));
    Register32_w R2(.input_data(w2), .clock(clk), .reset(rst), .output_data(w6));
    Register32_w R3(.input_data(w3), .clock(clk), .reset(rst), .output_data(w7));
    Register32_w R4(.input_data(w4), .clock(clk), .reset(rst), .output_data(w8));

    Adder A1(.i_operand1(w5), .i_operand2(w6),  .o_result(w9));
    Adder A2(.i_operand1(w7), .i_operand2(w8),  .o_result(w10));
    Adder A3(.i_operand1(w9), .i_operand2(w10), .o_result(w11));

    Register32_w R5(.input_data(w11), .clock(clk), .reset(rst), .output_data(o_result));
endmodule
