module Pu4(input [4:0] input1, input2, input3, input4, weight1, weight2, weight3, weight4, input clk, rst, output [11:0] out);

    wire [9:0] mul_out1, mul_out2, mul_out3, mul_out4;
    wire [9:0] mul_reg_out1, mul_reg_out2, mul_reg_out3, mul_reg_out4;
    wire [10:0] add_out1, add_out2;
    wire [11:0] add_out;

    assign mul_out1 = {3'b100, input1[8:7]};
    assign mul_out2 = {3'b100, input2[8:7]};
    assign mul_out3 = {3'b100, input3[8:7]};
    assign mul_out4 = input4;

//     Multiplier #(5) Mult1(.x(input1), .y(weight1), .z(mul_out1));
//     Multiplier #(5) Mult2(.x(input2), .y(weight2), .z(mul_out2));
//     Multiplier #(5) Mult3(.x(input3), .y(weight3), .z(mul_out3));
//     Multiplier #(5) Mult4(.x(input4), .y(weight4), .z(mul_out4));

    Register #(10) Rgstr1(.input_data(mul_out1), .clk(clk), .rst(rst), .en(1'b1), .out(mul_reg_out1));
    Register #(10) Rgstr2(.input_data(mul_out2), .clk(clk), .rst(rst), .en(1'b1), .out(mul_reg_out2));
    Register #(10) Rgstr3(.input_data(mul_out3), .clk(clk), .rst(rst), .en(1'b1), .out(mul_reg_out3));
    Register #(10) Rgstr4(.input_data(mul_out4), .clk(clk), .rst(rst), .en(1'b1), .out(mul_reg_out4));

    Adder #(10) Addr1(.A(mul_reg_out1), .B(mul_reg_out2),  .out(add_out1));
    Adder #(10) Addr2(.A(mul_reg_out3), .B(mul_reg_out4),  .out(add_out2));
    Adder #(10) Addr3(.A(add_out1), .B(add_out2), .out(add_out));

    Register #(12) R5(.input_data(add_out), .clk(clk), .rst(rst), .en(1'b1), .output_data(out));
endmodule
