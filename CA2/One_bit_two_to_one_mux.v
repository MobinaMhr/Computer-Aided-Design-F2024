module One_bit_two_to_one_mux (input D00, D01, sel, output out);

    Actel_C2 actl_c2_3(
        .out(out),
        .D00(D00),   .D01(D01), 
        .D10(1'bz),   .D11(1'bz), 
        .A1(1'b0), .B1(1'b0), 
        .A0(sel), .B0(1'b1)
    );

endmodule
