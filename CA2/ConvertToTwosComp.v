module ConvertToTwosComp #(parameter N = 10)(a, signbit, converted);

    input [N-1:0] a;
    input signbit;
    output [N-1:0] converted;

    wire [N-1:0] a_bar;
    wire [N-1:0] one;
    wire tempWire;

    // initial begin
    //     $display("In the convertToTwosComp: signbit=%b", signbit);
    //     $display("In the convertToTwosComp: a_bar=%b one=%b converted=%b", a_bar, one, converted);
    // end

    assign one = {{(N-1){1'b0}}, signbit };
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : XOR_LOOP
            C_XOR C_XOR_i(.a(a[i]), .b(signbit), .out(a_bar[i]));
        end
    endgenerate

    Adder #(N) AdderInConvertor(.A(a_bar), .B(one), .cin(1'b0), .out({tempWire, converted}));

endmodule
