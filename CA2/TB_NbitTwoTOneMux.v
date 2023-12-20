`timescale 1ns/1ns

module TB_NbitTwoTOneMux;
    parameter N = 5;

    reg [N-1:0] a, b;
    reg [0:0] sel;

    wire [N-1:0] out;

    N_bit_two_to_one_mux #(N) TB_NbitTwoTOneMuxIns (
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
    );

    initial begin
        a = 5'b01010; b = 5'b10101;
        sel = 1'b0;
        #5;
        $display("Test case 1: a = %b, b = %b, sel = %b, out = %b", a, b, sel, out);

        sel = 1'b1;
        #5;
        $display("Test case 2: a = %b, b = %b, sel = %b, out = %b", a, b, sel, out);

        $finish;
    end
endmodule
