module Shift_register(inp, clk, shift, final_output, outp);

    input [7:0] inp;
    input clk, shift, final_output;
    output reg [7:0] outp [0:3];

    reg [31:0] shift_mem;
    always @(posedge clk) begin
        if (shift) begin
            shift_mem <= {shift_mem[23:0], inp};
        end
    end

    always @(*) begin
        if (final_output) begin
            outp[0] = shift_mem[7:0];
            outp[1] = 8'd0;
            outp[2] = 8'd0;
            outp[3] = 8'd0;
        end
        else begin
            outp[0] = shift_mem[31:24];
            outp[1] = shift_mem[23:16];
            outp[2] = shift_mem[15:8];
            outp[3] = shift_mem[7:0];
        end
    end

endmodule