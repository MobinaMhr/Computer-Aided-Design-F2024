module Corr_calculator (clk, rst, window_buff_in, write_window_buff_en, filter_buff_in, write_filter_buff_en,
                        write_window_buff_ind, write_filter_buff_ind,
                        partial_res_en, reset_mac,
                        read_four_to_four_buff_ind, mac_out);

    input clk, rst, write_window_buff_en, write_filter_buff_en;
    input partial_res_en, reset_mac;
    input[7:0]window_buff_in[0:3];
    input[7:0]filter_buff_in[0:3];
    input[1:0] write_window_buff_ind, write_filter_buff_ind;
    input[3:0] read_four_to_four_buff_ind;

    output[11:0] mac_out;
    
    wire[7:0] filter_buff_out, window_buff_out;

    Filter_buffer window_buff(
        .inp(window_buff_in), .load(write_window_buff_en), 
        .clk(clk), .rst(rst), .index(read_four_to_four_buff_ind),
        .write_address({write_window_buff_ind,2'b0}), .outp(window_buff_out)
    );

    Filter_buffer filter_buff(
        .inp(filter_buff_in), .load(write_filter_buff_en),
        .clk(clk), .rst(rst), .index(read_four_to_four_buff_ind),
        .write_address({write_filter_buff_ind,2'b0}), .outp(filter_buff_out)
    );
        
    Mac mac(
        .clk(clk), .rst(rst), .reg_en(partial_res_en), .clean_reg(reset_mac), 
        .window(window_buff_out), .filter(filter_buff_out), .result(mac_out)
    );

endmodule