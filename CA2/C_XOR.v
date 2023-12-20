module C_XOR(input a, b, output out);


    One_bit_four_to_one_mux muxInCXor(
        .D00(1'b0), .D01(1'b1), 
        .D10(1'b1), .D11(1'b0), 
        .sel({a, b}), 
        .out(out)
    );

// in to code dirooz bood be bala avaz kardam
    // One_bit_four_to_one_mux muxInCXor(
    //     .a00(1'b0), .a01(1'b1), 
    //     .a10(1'b1), .a11(1'b0), 
    //     .sel({a, b}), 
    //     .out(out)
    // );

endmodule
