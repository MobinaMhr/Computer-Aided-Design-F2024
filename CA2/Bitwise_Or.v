module Bitwise_Or #(parameter N = 5) (input [N-1:0] a, output out);
    wire [N-1:0] res;
    assign res[0] = a[0];
    genvar i;
    generate
        for (i = 1; i < N; i = i + 1) begin : or_stage
            C_OR cOrInBwOr(
                .a(res[i-1]),
                .b(a[i]),
                .out(res[i])
            );
        end
    endgenerate
    assign out = res[N-1];
endmodule