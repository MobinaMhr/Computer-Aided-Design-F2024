module One_bit_four_to_one_mux (input D00, D01, D10, D11, input [1:0] sel, output out);

    Actel_C2 actl_c2_2(
        .out(out),
        .D00(D00),   .D01(D01), 
        .D10(D10),   .D11(D11), 
        .A1(sel[1]), .B1(1'b0), 
        .A0(sel[0]), .B0(1'b1)
    );

endmodule
