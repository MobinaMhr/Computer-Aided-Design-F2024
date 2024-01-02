module Top_module #(parameter WIDTH = 5) (clk, rst, start_signal, X1, X2, X3, X4, output_maximum_number, done);
    input clk, rst, start_signal;
    input [WIDTH-1:0] X1, X2, X3, X4;
    output [4:0] output_maximum_number;
    output done;

    wire done_signal, load_t, load_x, select_t;

    datapath #(WIDTH) datapath_instance(
        .clk(clk),
        .rst(rst),
        .ld_t(load_t),
        .sel_t(select_t),
        .maximum_number(output_maximum_number),
        .done(done_signal),
        .X1(X1),
        .X2(X2),
        .X3(X3),
        .X4(X4)
    );

    controller controller_instance (
        .datapath_done(done_signal),
        .start_signal(start_signal),
        .clk(clk),
        .rst(rst),
        .load_t(load_t),
        .sel_t(select_t),
        .done(done)
    );

    // assign done = done_signal;

endmodule