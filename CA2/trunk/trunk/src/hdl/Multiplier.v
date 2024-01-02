module Multiplier #(parameter NO_BITS = 5)(input [NO_BITS-1:0] x, y, output [2*NO_BITS-1:0] out);

    wire [2*NO_BITS - 1 : 0] z;
    wire areBothNeg;
    wire[NO_BITS-1:0] val_x, val_y;

    Convert_to_twosComp #(NO_BITS) GetXVal(
        .a(x),
        .signbit(x[NO_BITS-1]), 
        .converted(val_x)
    );
    
    Convert_to_twosComp #(NO_BITS) GetYVal(
        .a(y), 
        .signbit(y[NO_BITS-1]), 
        .converted(val_y)
    );

    C_XOR GetSignBit(
        .a(x[NO_BITS-1]), 
        .b(y[NO_BITS-1]), 
        .out(areBothNeg)
    );

    Convert_to_twosComp #(2*NO_BITS) twos_complement(
        .a(z), 
        .signbit(areBothNeg), 
        .converted(out)
    );

    wire xv [NO_BITS : 0][NO_BITS : 0], yv [NO_BITS : 0][NO_BITS : 0], 
            cv [NO_BITS : 0][NO_BITS : 0], pv [NO_BITS : 0][NO_BITS : 0];

    genvar i, j;
    generate
        for (i = 0; i < NO_BITS; i = i + 1)
        begin: gen_rows
            for (j = 0; j < NO_BITS; j = j + 1)
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
        for (i = 0; i < NO_BITS; i = i + 1)
        begin: sides
            assign xv[i][0] = val_x[i];
            assign cv[i][0] = 1'b0;
            assign pv[0][i + 1] = 1'b0;
            assign pv[i + 1][NO_BITS] = cv[i][NO_BITS];
            assign yv[0][i] = val_y[i];
            assign z[i] = pv[i + 1][0];
            assign z[i + NO_BITS] = pv[NO_BITS][i + 1];
        end
    endgenerate
    
endmodule
