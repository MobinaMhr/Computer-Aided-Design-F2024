`timescale 1ns/1ns

module TB_MULT();
    
    reg [4:0] a, b;
    wire [9:0] s;
    Multiplier #(5) TB_MULT_ins(.x(a), .y(b), .mOutput(s));

    initial begin
        a = 5'b00101;    // = 5/8
        b = 5'b01000; // = 1
        #10;
        $display("Test case 1: x = %b, y = %b, mOutput = %b", TB_MULT_ins.x, TB_MULT_ins.y, TB_MULT_ins.mOutput);

        a = 5'b00101;    // = 5/8
        b = 5'b11110; // = -0.25
        #10;
        $display("Test case 1: x = %b, y = %b, mOutput = %b", TB_MULT_ins.x, TB_MULT_ins.y, TB_MULT_ins.mOutput);

        $stop;
    end

endmodule