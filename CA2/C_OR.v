module C_OR(a, b, out);

    input wire[0:0] a, b;
    output wire[0:0] out;

    Actel_C2 c2(
        .out(out),
        .D00(1'b0), .D01(1'bz), 
        .D10(1'b1), .D11(1'bz), 
        .A1(a),     .B1(b), 
        .A0(1'b0),  .B0(1'b0)
    );

    // Actel_C1 actl_c1_(
    //     .F(out),
    //     .A0(a), .A1(1'b1), 
    //     .B0(1'b1), .B1(1'b1), 
    //     .SA(b), .SB(1'b1), 
    //     .S0(c), .S1(1'b0)
    // );


endmodule
