module Multiplier #(parameter N) (x, y, z);
    input [N - 1:0] x, y;

    output [2 * N - 1:0] z;

    wire xv [N:0][N:0];
    wire yv [N:0][N:0];
    wire cv [N:0][N:0];
    wire pv [N:0][N:0];

    genvar i, j;

    generate
        for (i = 0; i < N; i = i + 1) begin
            for (j = 0; j < N; j = j + 1) begin
                BIT_MULT bitMult_(
                    .xi(xv[i][j]),
                    .yi(yv[i][j]),
                    .pi(pv[i][j + 1]),
                    .ci(cv[i][j]),
                    .xo(xv[i][j + 1]),
                    .yo(yv[i + 1][j]),
                    .po(pv[i + 1][j]),
                    .co(cv[i][j + 1])
                );
            end
        end
    endgenerate

    generate
        for (i = 0; i < N; i = i + 1) begin
            assign xv[i][0] = x[i];
            assign cv[i][0] = 1'b0;
            assign pv[0][i + 1] = 1'b0;
            assign pv[i + 1][N] = cv[i][N];
            assign yv[0][i] = y[i];
            assign z[i] = pv[i + 1][0];
            assign z[i + N] = pv[N][i + 1];
        end
    endgenerate

endmodule