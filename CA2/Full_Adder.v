module Full_Adder(input a, b, cin, output s, cout);

    wire[0:0] a_xor_b;
    C_XOR xor1(.a(a), .b(b), .out(a_xor_b));
    C_XOR xor2(.a(a_xor_b), .b(cin), .out(s));

    wire[0:0] a_xor_b_and_cin, a_and_b;
    C_AND cAnd1(.a(a_xor_b), .b(cin), .out(a_xor_b_and_cin));
    C_AND cAnd2(.a(a), .b(b), .out(a_and_b));

    C_OR cOr1(.a(a_and_b), .b(a_xor_b_and_cin), .out(cout)); // in 1'b1 ro mobina ezafe kard.

endmodule