module Two_to_one_mux #(parameter NO_BITS) (sel, input_one, input_two, outp);

    input sel;
    input [NO_BITS-1:0] input_one;
    input [NO_BITS-1:0] input_two;
    output [NO_BITS-1:0] outp;

    assign outp = (sel == 1'b0) ? input_one: 
                    (sel == 1'b1) ? input_two: {NO_BITS{1'bx}};

endmodule
