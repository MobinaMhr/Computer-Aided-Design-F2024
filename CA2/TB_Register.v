`timescale 1ns/1ns  // Define timescale

module TB_Register;
    parameter WIDTH = 5;

    reg [WIDTH-1:0] inp;
    reg clk, rst, en;

    wire [WIDTH-1:0] out;

    Register #(WIDTH) TB_RegisterIns (
        .inp(inp),
        .clk(clk),
        .rst(rst),
        .en(en),
        .out(out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        rst = 0;
        #10;
        $display("out = %b   in reg: %b", out, TB_RegisterIns.out);


        en = 1;
        inp = 5'b10101;
        #20;
        $display("out = %b   in reg: %b", out, TB_RegisterIns.regOut);

        en = 0;
        #20;
        $display("out = %b   in reg: %b", out, TB_RegisterIns.regOut);

        rst = 1;
        rst = 0;
        #10;
        $display("out = %b   in reg: %b", out, TB_RegisterIns.regOut);

        en = 1;
        inp = 5'b01010;
        #20;
        $display("out = %b   in reg: %b", out, TB_RegisterIns.regOut);

        $stop;
    end
endmodule
