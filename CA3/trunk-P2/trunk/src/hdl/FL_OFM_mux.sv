module FL_OFM_mux #(parameter NO_BITS) (sel, d0, d1, d_out);

    input  [1:0] sel;
    input  [NO_BITS-1:0] d0, d1;
    output [NO_BITS-1:0] d_out;

    assign d_out = (sel == 2'd1) ? d0 : 
                      (sel == 2'd2) ? d1 :
                      {NO_BITS {1'bx}};

endmodule
