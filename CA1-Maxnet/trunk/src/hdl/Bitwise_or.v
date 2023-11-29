module Bitwise_or(bitwise_input, bitwise_output);

    input [31:0] bitwise_input;

    output bitwise_output;

    // Assign the output to the result of the bitwise OR operation on the input vector
    assign bitwise_output = |bitwise_input;

endmodule