module controller(input clk, start_signal, rst, datapath_done, output load_t, sel_t, done);

wire [2:0] ps_reg_out,ns_out,ns_in,ps_reg_out_not;
wire W1, W2, W3, W4, W5, W6, W7;
wire datapath_done_not, start_signal_not;
wire load_and_out;

Register #(3) ps (.inp(ns_out), .clk(clk), .rst(rst), .en(1'b1), .out(ps_reg_out));
Register #(3) ns (.inp(ns_in), .clk(clk), .rst(rst), .en(1'b1), .out(ns_out));

NOT not1(.A(ps_reg_out[0]), .out(ps_reg_out_not[0]));
NOT not2(.A(ps_reg_out[1]), .out(ps_reg_out_not[1]));
NOT not3(.A(ps_reg_out[2]), .out(ps_reg_out_not[2]));

AND3 done_out (.A(ps_reg_out_not[0]), .B(ps_reg_out_not[1]), .C(ps_reg_out_not[2]), .out(done));

AND3 load_and (.A(ps_reg_out_not[2]), .B(ps_reg_out[1]), .C(ps_reg_out_not[0]), .out(load_and_out));
AND3 sel_and (.A(ps_reg_out[2]), .B(ps_reg_out_not[1]), .C(ps_reg_out[0]), .out(sel_t));
C_OR load_or (.a(load_and_out), .b(sel_t), .out(load_t));

NOT not4(.A(datapath_done), .out(datapath_done_not));
NOT not5(.A(start_signal), .out(start_signal_not));

C_AND and1(.a(ps_reg_out[1]), .b(ps_reg_out_not[0]), .out(W1));
C_AND and2(.a(ps_reg_out[1]), .b(ps_reg_out[0]), .out(W2));
C_AND and3(.a(datapath_done_not), .b(ps_reg_out[2]), .out(W3));
C_AND and4(.a(ps_reg_out[2]), .b(ps_reg_out[0]), .out(W4));

AND3 and5(.A(start_signal),.B(ps_reg_out_not[2]), .C(ps_reg_out_not[1]), .out(W5));
AND3 and6(.A(start_signal_not),.B(ps_reg_out_not[1]), .C(ps_reg_out[0]), .out(W6));
AND3 and7(.A(datapath_done_not),.B(ps_reg_out[2]), .C(ps_reg_out_not[0]), .out(W7));

OR4 or1(.A(W1), .B(W3), .C(W4), .D(W5), .out(ns_in[0]));
OR3 or2(.A(W1), .B(W4), .C(W6), .out(ns_in[1]));
C_OR or3(.a(W2), .b(W7), .out(ns_in[2]));

endmodule