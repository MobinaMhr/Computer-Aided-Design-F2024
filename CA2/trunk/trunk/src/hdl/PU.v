module Pu(input [4:0] input1, input2, input3, input4, weight1, weight2, weight3, weight4, input clk, rst, output [11:0] out);

    wire [9:0] mul_out1, mul_out2, mul_out3, mul_out4;
    wire [9:0] mul_reg_out1, mul_reg_out2, mul_reg_out3, mul_reg_out4;
    wire [10:0] add_out1, add_out2;
    wire [11:0] add_out;

    Multiplier #(5) Mult1(.x(input1), .y(weight1), .out(mul_out1));
    Multiplier #(5) Mult2(.x(input2), .y(weight2), .out(mul_out2));
    Multiplier #(5) Mult3(.x(input3), .y(weight3), .out(mul_out3));
    Multiplier #(5) Mult4(.x(input4), .y(weight4), .out(mul_out4));

    Register #(10) Rgstr1(.inp(mul_out1), .clk(clk), .rst(rst), .en(1'b1), .out(mul_reg_out1));
    Register #(10) Rgstr2(.inp(mul_out2), .clk(clk), .rst(rst), .en(1'b1), .out(mul_reg_out2));
    Register #(10) Rgstr3(.inp(mul_out3), .clk(clk), .rst(rst), .en(1'b1), .out(mul_reg_out3));
    Register #(10) Rgstr4(.inp(mul_out4), .clk(clk), .rst(rst), .en(1'b1), .out(mul_reg_out4));

    Adder #(11) Addr1(.A({mul_reg_out1[9], mul_reg_out1}), .B({mul_reg_out2[9],mul_reg_out2}),.cin(1'b0),.out(add_out1));
    Adder #(11) Addr2(.A({mul_reg_out3[9],mul_reg_out3}), .B({mul_reg_out4[9],mul_reg_out4}),.cin(1'b0),.out(add_out2));
    
    Adder #(12) Addr3(.A({add_out1[10],add_out1}), .B({add_out2[10],add_out2}),.cin(1'b0),.out(add_out));

    Register #(12) R5(.inp(add_out), .clk(clk), .rst(rst), .en(1'b1), .out(out));
endmodule
