`timescale 1ns / 1ps

module TB_onebitmult;
    reg x_input, y_input;
    wire temp, tempX, tempY;
    wire cout;

    BIT_MULT TB_onebitmult_ins(
        .xi(x_input), .yi(y_input), .pi(1'b0), .ci(1'b0),
        .xo(tempX), .yo(tempY), .po(temp), .co(cout)
    );

    initial begin
        #10 x_input = 1'd1; y_input = 1'd1;
        #10 x_input = 1'd1; y_input = 1'd0;
        #10 x_input = 1'd0; y_input = 1'd0;
        #10 x_input = 1'd0; y_input = 1'd1;
        // #10 x_input = 8'hF0; y_input = 8'h0F;
        // #10 x_input = 8'h00; y_input = 8'hFF;
        // #10 x_input = 8'hFF; y_input = 8'h00;
        // #10 x_input = 8'h80; y_input = 8'h02;

        #10 $stop;
    end

endmodule
