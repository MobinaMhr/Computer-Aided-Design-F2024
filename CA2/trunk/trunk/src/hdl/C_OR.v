module C_OR(input a, b, output out);

    Actel_C2 c2(
        .out(out),
        .D00(1'b0),
        .D01(1'bz), 
        .D10(1'b1), 
        .D11(1'bz),
        .A1(a),
        .B1(b), 
        .A0(1'b0),
        .B0(1'b0)
    );

endmodule
