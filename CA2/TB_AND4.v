`timescale 1ns/1ns  // Define timescale

module TB_AND4;
    reg A, B, C, D;
    wire out;

    AND4 TB_AND4Ins (
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .out(out)
    );

    initial begin
        {A, B, C, D} = 4'b0000;
        #5;  // Wait for a few time units
        $display("Test case 1: A = %b, B = %b, C = %b, D = %b, out = %b", A, B, C, D, out);

        {A, B, C, D} = 4'b1111;
        #5;  // Wait for a few time units
        $display("Test case 2: A = %b, B = %b, C = %b, D = %b, out = %b", A, B, C, D, out);

        {A, B, C, D} = 4'b1011;
        #5;  // Wait for a few time units
        $display("Test case 1: A = %b, B = %b, C = %b, D = %b, out = %b", A, B, C, D, out);

        {A, B, C, D} = 4'b0100;
        #5;  // Wait for a few time units
        $display("Test case 1: A = %b, B = %b, C = %b, D = %b, out = %b", A, B, C, D, out);

        {A, B, C, D} = 4'b0010;
        #5;  // Wait for a few time units
        $display("Test case 1: A = %b, B = %b, C = %b, D = %b, out = %b", A, B, C, D, out);

        {A, B, C, D} = 4'b1101;
        #5;  // Wait for a few time units
        $display("Test case 2: A = %b, B = %b, C = %b, D = %b, out = %b", A, B, C, D, out);

        {A, B, C, D} = 4'b1001;
        #5;  // Wait for a few time units
        $display("Test case 1: A = %b, B = %b, C = %b, D = %b, out = %b", A, B, C, D, out);

        {A, B, C, D} = 4'b0111;
        #5;  // Wait for a few time units
        $display("Test case 1: A = %b, B = %b, C = %b, D = %b, out = %b", A, B, C, D, out);
        $stop;
    end
endmodule
