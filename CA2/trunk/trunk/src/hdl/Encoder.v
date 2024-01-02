// this module tells us that whether the maximum is find or not 
// if the maximum is find then, our output becomes its number to be selected 

module Encoder(input input_1, input_2, input_3, input_4, output [1:0] encoded_output);
    C_OR out0(.a(input_2), .b(input_4), .out(encoded_output[0]));
    C_OR out1(.a(input_3), .b(input_4), .out(encoded_output[1]));
    // assign encoded_output = (input_1 & ~input_2 & ~input_3 & ~input_4) ? 2'b00:
    //                          (~input_1 & input_2 & ~input_3 & ~input_4) ? 2'b01:
    //                          (~input_1 & ~input_2 & input_3 & ~input_4) ? 2'b10:
    //                          (~input_1 & ~input_2 & ~input_3 & input_4) ? 2'b11:
    //                          (~input_1 & ~input_2 & ~input_3 & ~input_4) ? 2'b00: 2'bxx; 

endmodule