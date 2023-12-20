module TB_Bitwise_And;
    reg [4:0] test_input;
    wire out;

    Bitwise_And TB_Bitwise_And_ins (
        .a(test_input),
        .out(out)
    );

    initial begin
                // Test case 1
        test_input = 5'b00000;
        #10; // Wait for 10 time units
        $display("Input: %b, Output: %b", test_input, out);

        // Test case 1
        test_input = 5'b00001;
        #10; // Wait for 10 time units
        $display("Input: %b, Output: %b", test_input, out);

        // Test case 2
        test_input = 5'b11110;
        #10;
        $display("Input: %b, Output: %b", test_input, out);

        // Test case 2
        test_input = 5'b11111;
        #10;
        $display("Input: %b, Output: %b", test_input, out);

        // Add more test cases as needed

        // End the simulation
        $finish;
    end
endmodule
