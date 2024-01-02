module AND3 (input A, B, C, output out);

    Actel_C1 and3(.A0(1'b0), .A1(1'b0), .SA(1'b0), .B0(1'b0), .B1(C), .SB(B), .S0(A), .S1(1'b0), .F(out));

endmodule