module Buffer (
    input clk,rst,
    output [4:0] W0,
    output [4:0] W1,
    output [4:0] W2,
    output [4:0] W3,
    output [4:0] W4,
    output [4:0] W5,
    output [4:0] W6,
    output [4:0] W7,
    output [4:0] W8,
    output [4:0] W9,
    output [4:0] W10,
    output [4:0] W11,
    output [4:0] W12,
    output [4:0] W13,
    output [4:0] W14,
    output [4:0] W15
);

Register#(5) reg1 (.inp(5'b01000) , .clk(clk) , .rst(1'b0) , .en(rst) , .out(W0));
Register#(5) reg2 (.inp(5'b11110) , .clk(clk) , .rst(1'b0) , .en(rst) , .out(W1));
Register#(5) reg3 (.inp(5'b11110) , .clk(clk) , .rst(1'b0) , .en(rst) , .out(W2));
Register#(5) reg4 (.inp(5'b11110) , .clk(clk) , .rst(1'b0) , .en(rst) , .out(W3));

Register#(5) reg5 (.inp(5'b11110) , .clk(clk) , .rst(1'b0) , .en(rst) , .out(W4));
Register#(5) reg6 (.inp(5'b01000) , .clk(clk) , .rst(1'b0) , .en(rst) , .out(W5));
Register#(5) reg7 (.inp(5'b11110) , .clk(clk) , .rst(1'b0) , .en(rst) , .out(W6));
Register#(5) reg8 (.inp(5'b11110) , .clk(clk) , .rst(1'b0) , .en(rst) , .out(W7));

Register#(5) reg9 (.inp(5'b11110) , .clk(clk) , .rst(1'b0) , .en(rst) , .out(W8));
Register#(5) reg10 (.inp(5'b11110) , .clk(clk) , .rst(1'b0) , .en(rst) , .out(W9));
Register#(5) reg11 (.inp(5'b01000) , .clk(clk) , .rst(1'b0) , .en(rst) , .out(W10));
Register#(5) reg12 (.inp(5'b11110) , .clk(clk) , .rst(1'b0) , .en(rst) , .out(W11));

Register#(5) reg13 (.inp(5'b11110) , .clk(clk) , .rst(1'b0) , .en(rst) , .out(W12));
Register#(5) reg14 (.inp(5'b11110) , .clk(clk) , .rst(1'b0) , .en(rst) , .out(W13));
Register#(5) reg15 (.inp(5'b11110) , .clk(clk) , .rst(1'b0) , .en(rst) , .out(W14));
Register#(5) reg16 (.inp(5'b01000) , .clk(clk) , .rst(1'b0) , .en(rst) , .out(W15));

endmodule