// this module tells us that whether the maximum is find or not 
// if the maximum is find then, our output becomes its number to be selected 

module Encoder(input_1, input_2, input_3, input_4, encoded_output);

    input input_1, input_2, input_3, input_4;
    output [1:0] encoded_output;

    assign encoded_output = (input_1 & ~input_2 & ~input_3 & ~input_4) ? 2'b00:
                             (~input_1 & input_2 & ~input_3 & ~input_4) ? 2'b01:
                             (~input_1 & ~input_2 & input_3 & ~input_4) ? 2'b10:
                             (~input_1 & ~input_2 & ~input_3 & input_4) ? 2'b11:
                             (~input_1 & ~input_2 & ~input_3 & ~input_4) ? 2'b00: 2'bxx; 

endmodule