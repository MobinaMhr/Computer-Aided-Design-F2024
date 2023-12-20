`timescale 1ns/1ns  // Define timescale

module TB_Encoder;
    reg input_1, input_2, input_3, input_4;

    wire [1:0] encoded_output;

    Encoder TB_EncoderIns (
        .input_1(input_1),
        .input_2(input_2),
        .input_3(input_3),
        .input_4(input_4),
        .encoded_output(encoded_output)
    );

    // Initial block for testbench stimulus
    initial begin
        input_1 = 1; input_2 = 0; input_3 = 1; input_4 = 0;
        #5;  // Wait for a few time units
        $display("Test case 1: input_1 = %b, input_2 = %b, input_3 = %b, input_4 = %b, encoded_output = %b", input_1, input_2, input_3, input_4, encoded_output);

        input_1 = 0; input_2 = 1; input_3 = 0; input_4 = 1;
        #5;  // Wait for a few time units
        $display("Test case 2: input_1 = %b, input_2 = %b, input_3 = %b, input_4 = %b, encoded_output = %b", input_1, input_2, input_3, input_4, encoded_output);

        $finish;
    end
endmodule
