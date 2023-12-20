`timescale 1ns/1ns

module TB_MULT();
    
    reg [4:0] a, b;
    wire [9:0] s;
    Multiplier #(5) TB_MULT_ins(a, b, s);

    initial begin
        a = 00101;    // = 5/8
        b = 5'b01000; // = 1
        #10;

        a = 00101;    // = 5/8
        b = 5'b11110; // = -0.25
        #10;

        $stop;
    end

endmodule