module Convert_to_twosComp #(parameter NO_BITS = 10)(input [NO_BITS-1:0] a, input signbit, output [NO_BITS-1:0] converted);

    wire [NO_BITS-1:0] a_not;
    wire [NO_BITS-1:0] one;
    assign one = {{(NO_BITS-1){1'b0}}, signbit };
    Adder #(NO_BITS) AdderInConvertor(.A(a_not), .B(one), .cin(1'b0), .out({converted}));
    genvar i;
    generate
        for (i = 0; i < NO_BITS; i = i + 1) begin : XOR_LOOP
            C_XOR C_XOR_i(.a(a[i]), .b(signbit), .out(a_not[i]));
        end
    endgenerate

endmodule
