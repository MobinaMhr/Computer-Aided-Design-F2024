module Actel_S2 (CLK, CLR, D00, D01, D10, D11, A1, B1, A0, B0, out);

    input CLK, CLR;
    input D00, D01, D10, D11;
    input A1, B1, A0, B0;
    output reg out;

    wire D;
    wire S0, S1;

    assign S0 = (A0 & B0);
    assign S1 = (A1 | B1);
    assign D = ({S1, S0} == 2'b00) ? D00 :
               ({S1, S0} == 2'b01) ? D01 :
               ({S1, S0} == 2'b10) ? D10 :
               ({S1, S0} == 2'b11) ? D11 : 1'bz;

    always @(posedge CLK) begin
        if(CLR)
            out = 0;
        else
            out = D;
    end

endmodule