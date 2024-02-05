module CNN #(parameter N) (clk, rst, start, x_inp, y_inp, z_inp, done);

    input clk, rst, start;
    input[$clog2(N*16+256)-1:0] x_inp, y_inp;
    input[7:0] z_inp;
    output done;
    
    wire[7:0] z_out, read_fl_ofm_addr, ofm_addr;
    wire[7:0] FL_output[0:N-1][0:3];
    wire [7:0] FL_OFMs_out [0:N-1][0:3];
    wire[7:0] SL_output[0:N-1][0:3];
    wire FL_mem_write_en, SL_mem_write_en;
    wire FL_done;
    wire FL_OFM_addr_sel, SL_OFM_addr_sel;
    wire[6:0] SL_ofm_wire_addr;
    wire ld_window_done, cout_addr_generator, addr_gen_line_cntr_en, addr_gen_windowpos_cntr_en;

    First_layer #(N) fl (
        .clk(clk), .rst(rst), .start(start), .x_inp(x_inp), .y_inp(y_inp),
        .z_inp(z_inp), .done(FL_done), .z_out(z_out), .mem_data_in(FL_output), 
        .mem_write_en(FL_mem_write_en), .FL_OFM_addr_sel(FL_OFM_addr_sel)
    );

    Address_generator addr_gen (
        .clk(clk), .rst(rst), .en_window_startpos_cntr(addr_gen_windowpos_cntr_en), 
        .en_line_cntr(addr_gen_line_cntr_en), .addr(read_fl_ofm_addr), 
        .cout_addr_generator(cout_addr_generator), .ld_window_done(ld_window_done)
    );

    FL_OFM_mux #($clog2(172)) Mux_OFM_Addr (
        .sel({FL_OFM_addr_sel, SL_OFM_addr_sel}),
        .d0(read_fl_ofm_addr), .d1(z_out), .d_out(ofm_addr)
    );

    genvar i;
    generate
    for(i = 0; i < N; i+=1)
        // OFM_memory #(172, i+1, "./outputs/output%0d_L1.txt") first_layer_OFM (
        OFM_memory #(172, i+1, "./../sim/file/outputs/output%0d_L1.txt") first_layer_OFM (
            .clk(clk), .w_en(FL_mem_write_en), 
            .done(FL_done), .addr(ofm_addr), 
            .inp(FL_output[i]), .d_out(FL_OFMs_out[i])
        );
    endgenerate

    Second_layer #(N) sl (
        .clk(clk), .rst(rst), .start(FL_done), .cout_addr_generator(cout_addr_generator), 
        .ld_window_done(ld_window_done), .done(done), .SL_mem_write_en(SL_mem_write_en), 
        .SL_OFM_addr_sel(SL_OFM_addr_sel), .write_output_addr(SL_ofm_wire_addr), 
        .write_data_mem(SL_output), .window_buff_in(FL_OFMs_out), 
        .addr_gen_line_cntr_en(addr_gen_line_cntr_en), 
        .addr_gen_windowpos_cntr_en(addr_gen_windowpos_cntr_en)
    );

    genvar j;
    generate
    for(j = 0; j < N; j+=1)
        Write_memory #(100, j+1, "./../sim/file/outputs/output%0d_L2.txt") second_layer_write_mem (
            .clk(clk), .write_en(SL_mem_write_en), 
            .done(done), .addr(SL_ofm_wire_addr), 
            .inp(SL_output[j])
        );
    endgenerate

endmodule