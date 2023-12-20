module Adder #(parameter NO_BITS) (input [NO_BITS - 1 : 0] A, input [NO_BITS - 1 : 0] B, input cin, output [NO_BITS : 0] out);
    wire [NO_BITS : 0] carry;
    assign carry[0] = cin;

    genvar i;
    generate
        for (i = 0; i < NO_BITS ; i = i + 1) begin: adders
            Full_Adder fullAddrIns(A[i],B[i],carry[i],out[i],carry[i+1]);
        end
    endgenerate

    assign out[NO_BITS] = carry[NO_BITS];

endmodule