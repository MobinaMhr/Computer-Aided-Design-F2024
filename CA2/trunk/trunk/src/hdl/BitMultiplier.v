module BIT_MULT(input xi, yi, pi, ci, output xo, yo, po, co);

    wire xi_and_yi;
    C_AND mul (.a(xi),.b(yi),.out(xi_and_yi));

    Full_Adder fullAdderInMultiplier(.a(pi), .b(xi_and_yi), .cin(ci), .s(po), .cout(co));

    assign xo = xi;
    assign yo = yi;

endmodule