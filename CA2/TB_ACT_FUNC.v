`timescale 1ns/1ns  // Define timescale

module TB_ACT_FUNC;
    // Inputs
    reg [11:0] in;

    // Output
    wire [4:0] out;

    // Instantiate the Activation_function module
    Activation_function TB_ACT_FUNCIns (
        .in(in),
        .out(out)
    );

    // Initial block for testbench stimulus
    initial begin
        // Test case 1
        in = 12'b110011001100;
        #5;  // Wait for a few time units
        $display("Test case 1: in = %b, out = %b", in, out);

        // Test case 2
        in = 12'b001100110011;
        #5;  // Wait for a few time units
        $display("Test case 2: in = %b, out = %b", in, out);

        // Add more test cases as needed

        // Terminate simulation
        $finish;
    end
endmodule
