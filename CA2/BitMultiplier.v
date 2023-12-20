module BIT_MULT(
    xi, yi, pi, ci,
    xo, yo, po, co
);
    input xi, yi, pi, ci;
    output xo, yo, po, co;

    wire xy, pi_and_xy, pi_and_ci, xy_and_ci;
    
    C_AND C_AND_1(.a(xi), .b(yi), .out(xy));
    C_AND C_AND_2(.a(pi), .b(xy), .out(pi_and_xy));
    C_AND C_AND_3(.a(pi), .b(ci), .out(pi_and_ci));
    C_AND C_AND_4(.a(xy), .b(ci), .out(xy_and_ci));

    // C_OR C_OR3_1(.a(pi_and_xy), .b(pi_and_ci), .c(xy_and_ci), .out(co));

    C_XOR C_XOR_1(.a(pi), .b(xy), .out(po));
    assign xo = xi;
    assign yo = yi;
    // BUF buf_1(xi, xo);
    // BUF buf_2(yi, yo);
endmodule


