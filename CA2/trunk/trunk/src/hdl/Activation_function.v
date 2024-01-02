module Activation_function(input [11:0] in, output [4:0] out);

    N_bit_two_to_one_mux muxInActvtFunc (
        {in[11],in[6:3]}, 
        5'b00000, 
        in[11],
        out
    );

endmodule