module TB_Adder;
    
    // Inputs
    reg [4:0] a, b;
    
    // Output
    wire [5:0] sum;
    
    // Instantiate the adder module
    Adder #(5) TB_Adder_ins(
        .A(a),
        .B(b),
        .cin(1'b0),
        .out(sum)
    );
    
    // Clock signal
    reg clk;
    
    // Test stimulus
    initial begin
        // Initialize inputs
        a = 5'b00000;
        b = 5'b00000;
        
        // Toggle clock
        clk = 0;
        #5;
        clk = 1;
        #5;
        
        // Perform addition
        a = 5'b11110;
        b = 5'b11111;
        
        // Toggle clock
        clk = 0;
        #5;
        clk = 1;
        #5;
        
        // Add more test cases here
        
        // End simulation
        $finish;
    end
    
endmodule
