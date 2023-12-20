module Multiplier #(parameter N = 5)(x, y, mOutput);

    input [N-1:0] x, y;
    output [2*N-1:0] mOutput;
    // input signed [N-1:0] x, y;
    // output signed [2*N-1:0] mOutput;

    wire [2*N - 1 : 0] z;
    wire areBothNeg;
    wire[N-1:0] val_x, val_y;

    ConvertToTwosComp #(N) GetXVal(
        .a(x), 
        .signbit(x[N-1]), 
        .converted(val_x)
    );
    ConvertToTwosComp #(N) GetYVal(
        .a(y), 
        .signbit(y[N-1]), 
        .converted(val_y)
    );

    initial begin
        $display("Multiplier| x=%b x[N-1]=%b", x, x[N-1]);
    end

    wire xv [N : 0][N : 0];
    wire yv [N : 0][N : 0];
    wire cv [N : 0][N : 0];
    wire pv [N : 0][N : 0];

    genvar i, j;
    generate
        for (i = 0; i < N; i = i + 1)
        begin: gen_rows
            for (j = 0; j < N; j = j + 1)
            begin: gen_cols
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
        for (i = 0; i < N; i = i + 1)
        begin: sides
            assign xv[i][0] = val_x[i];
            assign cv[i][0] = 1'b0;
            assign pv[0][i + 1] = 1'b0;
            assign pv[i + 1][N] = cv[i][N];
            assign yv[0][i] = val_y[i];
            assign z[i] = pv[i + 1][0];
            assign z[i + N] = pv[N][i + 1];
        end
    endgenerate
    
    C_XOR GetSignBit(
        .a(x[N-1]), 
        .b(y[n-1]), 
        .out(areBothNeg)
    );

    ConvertToTwosComp #(2*N) twos_complement(
        .a(z), 
        .signbit(areBothNeg), 
        .converted(mOutput)
    );
endmodule
