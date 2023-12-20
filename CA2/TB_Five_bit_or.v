module TB_Five_bit_or;

  // Inputs
  reg [4:0] inp;
  
  // Outputs
  wire out;

  // Instantiate the module
  Five_bit_or TB_Five_bit_or_ins (
    .inp(inp),
    .out(out)
  );

  // Clock generation
  reg clk = 0;
  always #5 clk = ~clk;

  // Initial block
  initial begin
    // Test case 1
    inp = 5'b00000;
    #10; // Wait for some time
    $display("Input: %b, Output: %b", inp, out);

    // Test case 2
    inp = 5'b00001;
    #10; // Wait for some time
    $display("Input: %b, Output: %b", inp, out);

    // Test case 3
    inp = 5'b00100;
    #10; // Wait for some time
    $display("Input: %b, Output: %b", inp, out);

    // Add more test cases as needed

    // Finish the simulation
    $finish;
  end

endmodule
