module datapath(clk, rst, ld_t, ld_x, sel_t, maximum_number, done);

    input clk, rst, ld_t, ld_x, sel_t;
    output [31:0] maximum_number;
    output done;

    wire [31:0] w1_P1, w2_P1, w3_P1, w4_P1;
    wire [31:0] w1_P2, w2_P2, w3_P2, w4_P2;
    wire [31:0] w1_P3, w2_P3, w3_P3, w4_P3;
    wire [31:0] w1_P4, w2_P4, w3_P4, w4_P4;

    wire [31:0] w1, w2, w3, w4, w6, w7, w8;
    wire [31:0] w9, w10, w11, w12, w13, w14;
    wire [31:0] w15, w16, w17, w22, w23, w24, w25;

    wire [31:0] data1, data2, data3, data4;
    wire [1:0] w5;
    wire w18, w19, w20, w21;

    Memory M(.clk(clk), .rst(rst), .read_data1(data1), .read_data2(data2), .read_data3(data3), .read_data4(data4));

    Register32 x1(.input_data(data1), .load(ld_x), .clock(clk), .reset(rst), .output_data(w1));
    Register32 x2(.input_data(data2), .load(ld_x), .clock(clk), .reset(rst), .output_data(w2));
    Register32 x3(.input_data(data3), .load(ld_x), .clock(clk), .reset(rst), .output_data(w3));
    Register32 x4(.input_data(data4), .load(ld_x), .clock(clk), .reset(rst), .output_data(w4));

    Mux_four_to_one M1(.input_1(w1), .input_2(w2), .input_3(w3), .input_4(w4), .select(w5), .mux_output(maximum_number));

    Mux_two_to_one M2(.input_1(w10), .input_2(data1), .select(sel_t), .mux_output(w6));
    Mux_two_to_one M3(.input_1(w11), .input_2(data2), .select(sel_t), .mux_output(w7));
    Mux_two_to_one M4(.input_1(w12), .input_2(data3), .select(sel_t), .mux_output(w8));
    Mux_two_to_one M5(.input_1(w13), .input_2(data4), .select(sel_t), .mux_output(w9));

    Register32 t1(.input_data(w6), .load(ld_t), .clock(clk), .reset(rst), .output_data(w14));
    Register32 t2(.input_data(w7), .load(ld_t), .clock(clk), .reset(rst), .output_data(w15));
    Register32 t3(.input_data(w8), .load(ld_t), .clock(clk), .reset(rst), .output_data(w16));
    Register32 t4(.input_data(w9), .load(ld_t), .clock(clk), .reset(rst), .output_data(w17));

    Bitwise_or B1(.bitwise_input(w14), .bitwise_output(w18));
    Bitwise_or B2(.bitwise_input(w15), .bitwise_output(w19));
    Bitwise_or B3(.bitwise_input(w16), .bitwise_output(w20));
    Bitwise_or B4(.bitwise_input(w17), .bitwise_output(w21));

    Encoder E(.input_1(w18), .input_2(w19), .input_3(w20), .input_4(w21), .encoded_output(w5));

    Done_checker D(.input1(w18), .input2(w19), .input3(w20), .input4(w21), .done_signal(done));

    Buffer buff(
        .W0(w1_P1),  .W1(w2_P1),  .W2(w3_P1),  .W3(w4_P1), 
        .W4(w1_P2),  .W5(w2_P2),  .W6(w3_P2),  .W7(w4_P2), 
        .W8(w1_P3),  .W9(w2_P3),  .W10(w3_P3), .W11(w4_P3), 
        .W12(w1_P4), .W13(w2_P4), .W14(w3_P4), .W15(w4_P4)
    );

    Pu P1(
        .input1(w14), .input2(w15), .input3(w16), .input4(w17), 
        .weight1(w1_P1), .weight2(w2_P1), .weight3(w3_P1), .weight4(w4_P1), 
        .clk(clk), .rst(rst), .o_result(w22)
    );
    Pu P2(
        .input1(w14), .input2(w15), .input3(w16), .input4(w17), 
        .weight1(w1_P2), .weight2(w2_P2), .weight3(w3_P2), .weight4(w4_P2), 
        .clk(clk), .rst(rst), .o_result(w23)
    );
    Pu P3(
        .input1(w14), .input2(w15), .input3(w16), .input4(w17), 
        .weight1(w1_P3), .weight2(w2_P3), .weight3(w3_P3), .weight4(w4_P3), 
        .clk(clk), .rst(rst), .o_result(w24)
    );
    Pu P4(
        .input1(w14), .input2(w15), .input3(w16), .input4(w17), 
        .weight1(w1_P4), .weight2(w2_P4), .weight3(w3_P4), .weight4(w4_P4), 
        .clk(clk), .rst(rst), .o_result(w25)
    );

    // all of these activation functions have a second 32'b0 input that if the number becomes
    // negative, we set it to 0
    Activation_function A1(.ac_in1(w22), .ac_in2(32'b0), .select(w22[31]), .ac_out(w10));
    Activation_function A2(.ac_in1(w23), .ac_in2(32'b0), .select(w23[31]), .ac_out(w11));
    Activation_function A3(.ac_in1(w24), .ac_in2(32'b0), .select(w24[31]), .ac_out(w12));
    Activation_function A4(.ac_in1(w25), .ac_in2(32'b0), .select(w25[31]), .ac_out(w13));

endmodule
