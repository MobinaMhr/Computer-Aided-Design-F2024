module Datapath #(parameter NO_BITS, N) (clk, rst, load_x, sel_x, load_y, sel_y, load_z, sel_z, mem_write_en, 
                                            write_main_buff_counter_en, read_main_buff_counter_en, shift_main_buff_en, 
                                            write_main_buff_en, write_filter_buff_counter_en, read_filter_buff_counter_en,
                                            partial_res_en, shift_reg_en, reset_mac, finalize_shift_reg, done,
                                            write_window_buff_en,mem_addr_sel, write_filter_buff_en, x_inp, y_inp, z_inp,
                                            write_filter_buff_counter_cout, read_filter_buff_counter_cout, 
                                            write_main_buff_counter_cout, read_main_buff_counter_cout);

    input clk, rst, load_x, sel_x, load_y, sel_y, load_z, sel_z, mem_write_en;
    input write_main_buff_counter_en, read_main_buff_counter_en, shift_main_buff_en;
    input write_main_buff_en, write_filter_buff_counter_en, read_filter_buff_counter_en;
    input partial_res_en, shift_reg_en, reset_mac, finalize_shift_reg, done;
    input write_window_buff_en,mem_addr_sel;
    input[0:N-1] write_filter_buff_en;
    input[NO_BITS-1:0] x_inp, y_inp;
    input[7:0] z_inp;
    output write_filter_buff_counter_cout, read_filter_buff_counter_cout;
    output write_main_buff_counter_cout, read_main_buff_counter_cout;

  wire[NO_BITS-1:0] x_out, y_out, mem_addr;
  wire[7:0] z_out;
  wire[7:0] mem_data_out[0:3]; 
  wire[7:0] main_buff_out[0:3][0:3];
  wire[7:0] window_buff_out;
  wire[3:0] read_main_buff_ind, read_four_to_four_buff_ind;
  wire[1:0] write_main_buff_ind, write_filter_buff_ind;

  Address_calculator #(NO_BITS) x_pc(.clk(clk), .rst(rst), .sel(sel_x), .increas_en(load_x), .init_pc(x_inp), .address(x_out));
  Address_calculator #(NO_BITS) y_pc(.clk(clk), .rst(rst), .sel(sel_y), .increas_en(load_y), .init_pc(y_inp), .address(y_out));
  Address_calculator #(8)       z_pc(.clk(clk), .rst(rst), .sel(sel_z), .increas_en(load_z), .init_pc(z_inp), .address(z_out));

  Two_to_one_mux #(NO_BITS) mem_addr_mux (.sel(mem_addr_sel),.input_one(x_out), .input_two(y_out), .outp(mem_addr));

  Read_memory #(256 + N*16, NO_BITS) read_mem(.clk(clk), .done(done), .addr(mem_addr), .outp(mem_data_out));

  Two_bit_counter main_buff_write_counter(.clk(clk), .rst(rst), .count_en(write_main_buff_counter_en),
                                          .cout(write_main_buff_counter_cout), .result(write_main_buff_ind));

  Up_12_counter main_buff_read_counter(.clk(clk), .rst(rst), .count_en(read_main_buff_counter_en),
                                        .cout(read_main_buff_counter_cout), .result(read_main_buff_ind));

  Four_bit_counter corr_counter(.clk(clk), .rst(rst), .count_en(read_filter_buff_counter_en),
            .cout(read_filter_buff_counter_cout), .result(read_four_to_four_buff_ind));

  Two_bit_counter filter_buff_write_counter(.clk(clk), .rst(rst), .count_en(write_filter_buff_counter_en), 
                                            .cout(write_filter_buff_counter_cout), .result(write_filter_buff_ind));

  Main_buffer main_buff(.clk(clk), .rst(rst), .shift_up(shift_main_buff_en), .write_en(write_main_buff_en), .write_data(mem_data_out),
                        .read_index(read_main_buff_ind), .write_index({write_main_buff_ind,2'b0}), .read_data(main_buff_out));

  Window_buffer window_buff(.inp(main_buff_out), .load(write_window_buff_en), .clk(clk), 
                            .rst(rst), .index(read_four_to_four_buff_ind), .outp(window_buff_out));

  genvar i;
  generate
    for(i = 0; i < N; i+=1)
      PE #(i) pe(.clk(clk), .rst(rst), .mem_write_en(mem_write_en), .write_filter_buff_en(write_filter_buff_en[i]), 
                .partial_res_en(partial_res_en), .reset_mac(reset_mac), .shift_reg_en(shift_reg_en), .finalize_shift_reg(finalize_shift_reg),
                .mem_data_out(mem_data_out), .window_buff_out(window_buff_out), .read_four_to_four_buff_ind(read_four_to_four_buff_ind),
                .write_filter_buff_ind(write_filter_buff_ind), .z_out(z_out), .done(done));
  endgenerate

  endmodule
