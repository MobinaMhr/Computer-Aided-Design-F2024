module Actel_C1(input A0, A1, SA, B0, B1, SB, S0, S1, output F);

    wire[0:0] F1 = (SA) ? A1 : A0;
    wire[0:0] F2 = (SB) ? B1 : B0;    
    assign F = (S0 | S1) ? F2 : F1;

endmodule
