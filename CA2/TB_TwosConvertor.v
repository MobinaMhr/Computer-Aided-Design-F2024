// 

`timescale 1ns/1ns  // Define timescale

module TB_TwosConvertor;
    parameter N = 10;

    reg [N-1:0] a;
    reg signbit;

    wire [N-1:0] out;

    ConvertToTwosComp #(N) TB_TwosConvertorIns (
        .a(a),
        .signbit(signbit),
        .converted(out)
    );

    initial begin
        a = 10'b0110110101;
        signbit = 1'b0;
        #5;  // Wait for a few time units
        $display("Test case 1: a = %b, signbit = %b, out = %b", a, signbit, out);

        a = 10'b0110110101;
        signbit = 1'b1;
        #5;  // Wait for a few time units
        $display("Test case 2: a = %b, signbit = %b, out = %b", a, signbit, out);

        $stop;
    end
endmodule


