`timescale 1ns/1ns

module TB_fullAddr;

    // Inputs
    reg a, b, cin;
    
    // Outputs
    wire s, cout;

    // Instantiate the Full_Adder module
    Full_Adder TB_fullAddr_ins (
        .a(a),
        .b(b),
        .cin(cin),
        .s(s),
        .cout(cout)
    );

    // Clock generation
    reg clk = 0;
    always #5 clk = ~clk;

    // Test stimulus
    initial begin
        // Test case 1
        a = 1'b0; b = 1'b0; cin = 1'b0;
        #10;

        // Test case 2
        a = 1'b1; b = 1'b1; cin = 1'b1;
        #10;

        // Add more test cases as needed...

        // End simulation
        $finish;
    end

    // Display results
    always @(posedge clk) begin
        $display("Time=%t A=%b B=%b Cin=%b Sum=%b Cout=%b", $time, a, b, cin, s, cout);
    end

endmodule
