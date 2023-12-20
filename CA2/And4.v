module AND4 (input A, B, C, D, output out);

    Actel_C2 and4_to_1 (.D00(1'b0), .D01(1'b0), .D10(1'b0), .D11(D), .A1(C), .B1(1'b0), .A0(A), .B0(B), .out(out));

endmodule