`timescale 1ns/1ns  // Define timescale

module TB_Actel_S2;
    reg CLK, CLR;
    reg D00, D01, D10, D11;
    reg A1, B1, A0, B0;
    wire out;

    Actel_S2 TB_Actel_S2Ins (
        .CLK(CLK),
        .CLR(CLR),
        .D00(D00),
        .D01(D01),
        .D10(D10),
        .D11(D11),
        .A1(A1),
        .B1(B1),
        .A0(A0),
        .B0(B0),
        .out(out)
    );

    initial begin
        CLR = 1;
        CLK = 1;
        CLR = 0;
        D00 = 0; D01 = 1; D10 = 1; D11 = 0;
        A1 = 1; B1 = 0; A0 = 1; B0 = 0;
        #5;  // Wait for a few time units
        $display("Test case 1: S0 = %b, S1 = %b, out = %b D=%b", TB_Actel_S2Ins.S0, TB_Actel_S2Ins.S1, out, TB_Actel_S2Ins.D);
        $finish;
    end
endmodule