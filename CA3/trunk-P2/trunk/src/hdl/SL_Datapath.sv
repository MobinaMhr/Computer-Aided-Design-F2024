module SL_Datapath #(parameter N) (clk, rst, load_z_prime, load_filters_pc,
                                    write_filter_buff_counter_en, write_window_buff_counter_en,
                                    write_window_buff_en, read_window_filter_counter_en, shift_reg_en,
                                    partial_res_en, reset_mac, write_filter_buff_en, window_buff_in,
                                    write_output_addr, write_data_mem, write_filter_buff_counter_cout, 
                                    read_window_filter_counter_cout);

    input clk, rst, load_z_prime, load_filters_pc;
    input write_filter_buff_counter_en, write_window_buff_counter_en;
    input write_window_buff_en;
    input read_window_filter_counter_en, shift_reg_en;
    input partial_res_en, reset_mac;

    input [0:N-1] write_filter_buff_en;
    input [7:0] window_buff_in [0:N-1][0:3];
    output[6:0] write_output_addr;
    output[7:0] write_data_mem[0:N-1][0:3];

    output write_filter_buff_counter_cout, read_window_filter_counter_cout;

    wire[$clog2(N*4*4)-1:0] filters_addr;
    wire[1:0] write_filter_buff_ind, write_window_buff_ind;
    wire[3:0] read_four_to_four_buff_ind;
    wire[7:0] filter_mem_out[0:N-1][0:3];

    PC #($clog2(N*4*4)) SL_filters_pc(
        .clk(clk), .rst(rst), .sel(1'b0), 
        .increas_en(load_filters_pc),
        .init_pc({$clog2(N*4*4){1'b0}}), 
        .address(filters_addr)
    );

    Two_bit_counter write_index_filter_counter(
        .clk(clk), .rst(rst), 
        .count_en(write_filter_buff_counter_en), 
        .cout(write_filter_buff_counter_cout), 
        .result(write_filter_buff_ind)
    );

    Two_bit_counter write_index_window_counter(
        .clk(clk), .rst(rst), 
        .count_en(write_window_buff_counter_en), 
        .cout(write_window_buff_counter_cout), 
        .result(write_window_buff_ind)
    );

    Four_bit_counter window_filter_read_index_counter(
        .clk(clk), .rst(rst), 
        .count_en(read_window_filter_counter_en),
        .cout(read_window_filter_counter_cout), 
        .result(read_four_to_four_buff_ind)
    );

    genvar i;
    generate
        for(i = 0; i < N; i+=1)
            Read_memory #(N*4*4, $clog2(N*4*4), ($sformatf("./../sim/file/inputs/filter%0d_L2.txt", i+1)))
                F_M(.clk(clk), .addr(filters_addr), .outp(filter_mem_out[i]));
    endgenerate

    genvar j;
    generate
        for(j = 0; j < N; j+=1)
            SL_PE #(N) sl_pe(
                .clk(clk), .rst(rst), .shift_reg_en(shift_reg_en), 
                .window_buff_in(window_buff_in), .filter_buff_in(filter_mem_out[j]),
                .write_window_buff_en(write_window_buff_en), 
                .write_filter_buff_en(write_filter_buff_en),
                .reset_mac(reset_mac), .partial_res_en(partial_res_en),
                .write_window_buff_ind(write_window_buff_ind), 
                .write_filter_buff_ind(write_filter_buff_ind),
                .read_four_to_four_buff_ind(read_four_to_four_buff_ind), 
                .write_data_mem(write_data_mem[j])
            );
    endgenerate

    PC #(7) z_prime_pc(
        .clk(clk), .rst(rst), .sel(1'b0), .increas_en(load_z_prime),
        .init_pc(7'd0), .address(write_output_addr)
    );

endmodule