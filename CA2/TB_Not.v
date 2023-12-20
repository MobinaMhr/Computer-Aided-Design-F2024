`timescale 1ns / 1ps

module TB_Not();
    reg inputX;
    wire outputX;

    NOT TB_Not_ins (.A(inputX), .out(outputX));

    initial begin
        #10 inputX = 1'd1;
        #10 inputX = 1'd0;
        #10 $stop;
    end

endmodule

