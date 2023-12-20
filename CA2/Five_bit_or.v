module Five_bit_or(input [4:0] inp, output out);

    wire firt3_0 ;
    Actel_C2 first_three_bit_or(.D00(1'b0), .D01(1'b1), .D10(1'b1), .D11((1'b1)), .A1(inp[1]), .B1(inp[2]), .A0(inp[0]), .B0(inp[0]), .out(firt3_0));
    Actel_C2 res (.D00(1'b0), .D01(1'b1), .D10(1'b1), .D11(1'b1), .A1(inp[3]), .B1(inp[4]), .A0(firt3_0), .B0(firt3_0),.out(out));

endmodule
