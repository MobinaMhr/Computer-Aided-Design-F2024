`timescale 1ns/1ns

module TB_NbitFourTOneMux;
    parameter N = 5;

    reg [N-1:0] a, b, c, d;
    reg [1:0] sel;

    wire [N-1:0] out;

    N_bit_four_to_one_mux #(N) TB_NbitFourTOneMuxIns (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .sel(sel),
        .out(out)
    );

    initial begin
        a = 5'b01010; b = 5'b10101; c = 5'b11011; d = 5'b11100;
        sel = 2'b00;
        #5;
        $display("Test case 1: a = %b, b = %b, c = %b, d = %b, sel = %b, out = %b", a, b, c, d, sel, out);

        sel = 2'b01;
        #5;
        $display("Test case 2: a = %b, b = %b, c = %b, d = %b, sel = %b, out = %b", a, b, c, d, sel, out);

        $finish;
    end
endmodule
