module NOT (input A, output out);

    Actel_C1 not_actl(.A0(1'b1), .A1(1'b1), .SA(1'b1), .B0(1'b0), .B1(1'b0), .SB(1'b0), .S0(A), .S1(1'b0), .F(out));

endmodule