module SL_PE #(parameter N) (clk, rst, shift_reg_en, window_buff_in, filter_buff_in,
                                write_window_buff_en, write_filter_buff_en, reset_mac, partial_res_en,
                                write_window_buff_ind, write_filter_buff_ind, read_four_to_four_buff_ind, write_data_mem);

    input clk, rst, write_window_buff_en;
    input shift_reg_en, reset_mac, partial_res_en;

    input [7:0] window_buff_in [0:N-1][0:3];
    input[7:0] filter_buff_in [0:3];
    input [0:N-1] write_filter_buff_en;
    input[1:0] write_window_buff_ind, write_filter_buff_ind;
    input[3:0] read_four_to_four_buff_ind;
    
    output[7:0] write_data_mem [0:3];

    wire[11:0] macs_output[0:N-1];
    wire[7:0] add_out;

    genvar i;
    generate
        for(i = 0; i < N; i+=1)
            Corr_calculator Cc(
                .clk(clk), .rst(rst), .window_buff_in(window_buff_in[i]), 
                .write_window_buff_en(write_window_buff_en), .filter_buff_in(filter_buff_in), 
                .write_filter_buff_en(write_filter_buff_en[i]), .reset_mac(reset_mac), 
                .partial_res_en(partial_res_en), .write_window_buff_ind(write_window_buff_ind), 
                .write_filter_buff_ind(write_filter_buff_ind), 
                .read_four_to_four_buff_ind(read_four_to_four_buff_ind), .mac_out(macs_output[i])
            );
    endgenerate

    Mac_out_adder #(N) adder (
        .macs_output(macs_output), 
        .add_out(add_out)
    );

    Shift_register shift_reg(
        .inp(add_out), .clk(clk), .shift(shift_reg_en), 
        .final_output(1'b0), .outp(write_data_mem)
    );

endmodule