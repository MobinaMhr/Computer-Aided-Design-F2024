module C_AND(input a, b, output out);

    Actel_C2 actl_c2_1(
        .out(out),
        .D00(1'b0),
        .D01(1'b1), 
        .D10(1'bz),
        .D11(1'bz), 
        .A1(1'b0),
        .B1(1'b0),
        .A0(a),
        .B0(b) 
    );

endmodule
