module N_bit_two_to_one_mux #(parameter N = 5) (
    input [N-1:0] a,
    input [N-1:0] b,
    input sel,
    output [N-1:0] out
);
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin: mux_gen
            One_bit_two_to_one_mux one_bit_mux (.D00(a[i]), .D01(b[i]), .sel(sel), .out(out[i]));
        end
    endgenerate
endmodule
