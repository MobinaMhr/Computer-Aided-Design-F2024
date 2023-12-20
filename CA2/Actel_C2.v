module Actel_C2 (input D00, D01, D10, D11, A1, B1, A0, B0, output out);

    wire S0 = A0 & B0;
    wire S1 = A1 | B1;
    assign out = ({S1, S0} == 2'b00) ? D00 :
                 ({S1, S0} == 2'b01) ? D01 :
                 ({S1, S0} == 2'b10) ? D10 :
                 ({S1, S0} == 2'b11) ? D11 : 'bz;

endmodule