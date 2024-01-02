
`timescale 1ns/1ns

module TB;
    parameter WIDTH = 5;

    reg [WIDTH-1:0] X1, X2, X3, X4;
    reg clk, rst, start_signal;
    wire done;

    wire [WIDTH-1:0] out;

    Top_module #(WIDTH) uut (
        .X1(X1),
        .X2(X2),
        .X3(X3),
        .X4(X4),
        .clk(clk),
        .rst(rst),
        .start_signal(start_signal),
        .output_maximum_number(out),
        .done(done)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        X1 = 5'b01000; // 1.0
        X2 = 5'b00110; // 0.75
        X3 = 5'b00100; // 0.5
        X4 = 5'b00010; // 0.25
        // X1 = 5'b00010;
        // X2 = 5'b00010;
        // X3 = 5'b01000;
        // X4 = 5'b00010;
        #15 rst = 0;
        
        start_signal = 1'b1;
        #15 start_signal = 1'b0;

        wait(done == 1'b1)
        #20 $stop;
    end
endmodule
