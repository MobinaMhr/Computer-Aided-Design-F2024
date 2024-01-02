module OR3 (input A, B, C, output out);

    Actel_C1 or3(.A0(A), .A1(1'b1), .SA(B), .B0(1'b1), .B1(1'b1), .SB(1'b1), .S0(C), .S1(1'b0), .F(out));


endmodule