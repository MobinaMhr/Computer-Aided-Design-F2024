module datapath #(parameter WIDTH = 5) (input [WIDTH - 1:0] X1, X2, X3, X4,
            input clk, rst, ld_t, sel_t, 
            output [4:0] maximum_number, 
            output done);

    wire [WIDTH-1:0] w1_P1, w2_P1, w3_P1, w4_P1;
    wire [WIDTH-1:0] w1_P2, w2_P2, w3_P2, w4_P2;
    wire [WIDTH-1:0] w1_P3, w2_P3, w3_P3, w4_P3;
    wire [WIDTH-1:0] w1_P4, w2_P4, w3_P4, w4_P4;

    wire [WIDTH-1:0] w1, w2, w3, w4;
    wire [11:0] PU_out1, PU_out2, PU_out3, PU_out4;
    wire [WIDTH-1:0] AF_out1, AF_out2, AF_out3, AF_out4;
    wire [WIDTH-1:0] t1_out, t2_out, t3_out, t4_out;
    wire [1:0] res_sel;
    wire t1_ored, t2_ored, t3_ored, t4_ored;

    N_bit_four_to_one_mux #(WIDTH) nBitMux1(.a(X1), .b(X2), .c(X3), .d(X4), .sel(res_sel), .out(maximum_number));

    N_bit_two_to_one_mux #(WIDTH) M2(.a(X1), .b(AF_out1), .sel(sel_t), .out(w1));
    N_bit_two_to_one_mux #(WIDTH) M3(.a(X2), .b(AF_out2), .sel(sel_t), .out(w2));
    N_bit_two_to_one_mux #(WIDTH) M4(.a(X3), .b(AF_out3), .sel(sel_t), .out(w3));
    N_bit_two_to_one_mux #(WIDTH) M5(.a(X4), .b(AF_out4), .sel(sel_t), .out(w4));

    Register #(5) temp1(.inp(w1), .en(ld_t), .clk(clk), .rst(rst), .out(t1_out));
    Register #(5) temp2(.inp(w2), .en(ld_t), .clk(clk), .rst(rst), .out(t2_out));
    Register #(5) temp3(.inp(w3), .en(ld_t), .clk(clk), .rst(rst), .out(t3_out));
    Register #(5) temp4(.inp(w4), .en(ld_t), .clk(clk), .rst(rst), .out(t4_out));

    Five_bit_or fBitOr1(.inp(AF_out1), .out(t1_ored));
    Five_bit_or fBitOr2(.inp(AF_out2), .out(t2_ored));
    Five_bit_or fBitOr3(.inp(AF_out3), .out(t3_ored));
    Five_bit_or fBitOr4(.inp(AF_out4), .out(t4_ored));

    Encoder Encdr(.input_1(t1_ored), .input_2(t2_ored), .input_3(t3_ored), .input_4(t4_ored), .encoded_output(res_sel));

    Done_checker D(.input1(t1_ored), .input2(t2_ored), .input3(t3_ored), .input4(t4_ored), .done_signal(done));

    Buffer buff(
        .clk(clk),.rst(rst),
        .W0(w1_P1),  .W1(w2_P1),  .W2(w3_P1),  .W3(w4_P1), 
        .W4(w1_P2),  .W5(w2_P2),  .W6(w3_P2),  .W7(w4_P2), 
        .W8(w1_P3),  .W9(w2_P3),  .W10(w3_P3), .W11(w4_P3), 
        .W12(w1_P4), .W13(w2_P4), .W14(w3_P4), .W15(w4_P4)
    );

    Pu Pu_1(
        .input1(t1_out), .input2(t2_out), .input3(t3_out), .input4(t4_out), 
        .weight1(w1_P1), .weight2(w2_P1), .weight3(w3_P1), .weight4(w4_P1), 
        .clk(clk), .rst(rst), .out(PU_out1)
    );
    
    Pu Pu_2(
        .input1(t1_out), .input2(t2_out), .input3(t3_out), .input4(t4_out), 
        .weight1(w1_P2), .weight2(w2_P2), .weight3(w3_P2), .weight4(w4_P2), 
        .clk(clk), .rst(rst), .out(PU_out2)
    );
    
    Pu Pu_3(
        .input1(t1_out), .input2(t2_out), .input3(t3_out), .input4(t4_out), 
        .weight1(w1_P3), .weight2(w2_P3), .weight3(w3_P3), .weight4(w4_P3), 
        .clk(clk), .rst(rst), .out(PU_out3)
    );
    
    Pu Pu_4(
        .input1(t1_out), .input2(t2_out), .input3(t3_out), .input4(t4_out), 
        .weight1(w1_P4), .weight2(w2_P4), .weight3(w3_P4), .weight4(w4_P4), 
        .clk(clk), .rst(rst), .out(PU_out4)
    );
  

    Activation_function AFunc1(.in(PU_out1), .out(AF_out1));
    Activation_function AFunc2(.in(PU_out2), .out(AF_out2));
    Activation_function AFunc3(.in(PU_out3), .out(AF_out3));
    Activation_function AFunc4(.in(PU_out4), .out(AF_out4));

endmodule
