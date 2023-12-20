`timescale 1ns/1ns  // Define timescale

module TB_Buffer;
    // Inputs
    reg clk, rst;

    // Outputs
    wire [4:0] W0, W1, W2, W3, W4, W5, W6, W7, W8, W9, W10, W11, W12, W13, W14, W15;

    // Instantiate the Buffer module
    Buffer TB_BufferIns (
        .clk(clk),
        .rst(rst),
        .W0(W0),
        .W1(W1),
        .W2(W2),
        .W3(W3),
        .W4(W4),
        .W5(W5),
        .W6(W6),
        .W7(W7),
        .W8(W8),
        .W9(W9),
        .W10(W10),
        .W11(W11),
        .W12(W12),
        .W13(W13),
        .W14(W14),
        .W15(W15)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Toggle the clock every 5 time units
    end

    // Initial block for testbench stimulus
    initial begin
        // Test case 1: Apply reset and check the outputs
        rst = 1;
        #10;  // Wait for a few clock cycles
        rst = 0;
        #10;  // Wait for a few clock cycles

        $display("Test case 1: W0 = %b, W1 = %b, W2 = %b, W3 = %b, W4 = %b, W5 = %b, W6 = %b, W7 = %b, W8 = %b, W9 = %b, W10 = %b, W11 = %b, W12 = %b, W13 = %b, W14 = %b, W15 = %b",
                 W0, W1, W2, W3, W4, W5, W6, W7, W8, W9, W10, W11, W12, W13, W14, W15);

        // Add more test cases as needed

        // Terminate simulation
        $finish;
    end
endmodule
