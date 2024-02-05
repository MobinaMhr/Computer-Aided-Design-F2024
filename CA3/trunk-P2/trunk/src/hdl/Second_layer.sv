module Second_layer #(parameter N) (clk, rst, start, cout_addr_generator, ld_window_done, done,
                                     SL_mem_write_en, SL_OFM_addr_sel, write_output_addr, write_data_mem,
                                     addr_gen_windowpos_cntr_en, addr_gen_line_cntr_en, window_buff_in);

    input clk, rst, start, cout_addr_generator, ld_window_done;
    input [7:0] window_buff_in [0:N-1][0:3];

    output done, SL_mem_write_en, SL_OFM_addr_sel;
    output addr_gen_windowpos_cntr_en, addr_gen_line_cntr_en;
    output[6:0] write_output_addr;
    output[7:0] write_data_mem[0:N-1][0:3];

    wire sel1, sel2, sel3;
    wire cout1, cout2, cout3, cout4;
    wire en1, en2, en3, en4;
    wire en7, en8, en9;
    wire clc_mac , temp_done;
    wire [0:N-1] en6;

    SL_Datapath #(N) dPath(
        .clk(clk), .rst(rst), .load_z_prime(en9), .load_filters_pc(en1), .write_filter_buff_counter_en(en2),
        .write_window_buff_counter_en(addr_gen_line_cntr_en), .write_window_buff_en(en3),
        .read_window_filter_counter_en(en4), .shift_reg_en(en7), .partial_res_en(en5), 
        .reset_mac(clc_mac), .write_filter_buff_en(en6), .write_output_addr(write_output_addr), 
        .write_data_mem(write_data_mem), .write_filter_buff_counter_cout(cout2),
        .read_window_filter_counter_cout(cout1), .window_buff_in(window_buff_in)
    );

    SL_Controller #(N) ctrlr(
        .clk(clk), .start(start), .rst(rst),
        .cout_addr_generator(cout_addr_generator), .ld_window_done(ld_window_done),
        .addr_gen_line_cntr_en(addr_gen_line_cntr_en),
        .addr_gen_windowpos_cntr_en(addr_gen_windowpos_cntr_en),
        .read_window_filter_cntr_cout(cout1), .write_filter_buff_cntr_cout(cout2), .write_filter_buff_en(en6),
        .ld_filters_pc(en1), .write_filter_buff_cntr_en(en2), .write_window_buff_en(en3), .sel_mem(SL_OFM_addr_sel),
        .read_window_filter_cntr_en(en4), .partial_res_en(en5), .shiftreg_en(en7), .rst_mac(clc_mac),
        .done(temp_done), .mem_write_en(SL_mem_write_en), .ld_z_prime(en9)
    );
        
    assign done = temp_done;

endmodule
