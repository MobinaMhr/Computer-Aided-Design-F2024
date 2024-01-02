module Register #(parameter WIDTH = 5)(input [WIDTH-1:0] inp , input clk , rst , en , output [WIDTH-1:0] out);

    genvar i;
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : reg_block
            Actel_S2 actl_s2_(
                .out(out[i]),
                .D00(out[i]),
                .D01(1'bz),
                .D10(inp[i]),
                .D11(1'bz),
                .A1(en),
                .B1(1'b0), 
                .A0(1'b0),
                .B0(1'b0), 
                .CLR(rst),
                .CLK(clk) 
            );
        end
    endgenerate

endmodule
