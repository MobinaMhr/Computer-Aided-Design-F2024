module PE #(parameter NUM) (clk, rst, write_filter_buff_en, partial_res_en, 
                                reset_mac, shift_reg_en, finalize_shift_reg,
                                mem_data_out, window_buff_out, read_four_to_four_buff_ind,
                                write_filter_buff_ind, mem_data_in);


    input clk, rst, write_filter_buff_en;
    input partial_res_en, reset_mac, shift_reg_en;
    input finalize_shift_reg;
    input[7:0] mem_data_out[0:3];
    input[7:0] window_buff_out;
    input[3:0] read_four_to_four_buff_ind;
    input[1:0] write_filter_buff_ind;
    
    output[7:0] mem_data_in[0:3];

    wire[7:0] filter_buff_out;
    wire[11:0] mac_out;

    Filter_buffer filter_buff(
        .inp(mem_data_out), .load(write_filter_buff_en), 
        .clk(clk), .rst(rst), .index(read_four_to_four_buff_ind),
        .write_address({write_filter_buff_ind,2'b0}), 
        .outp(filter_buff_out)
    );

    Mac mac(
        .clk(clk), .rst(rst), .reg_en(partial_res_en), .clean_reg(reset_mac), 
        .window(window_buff_out), .filter(filter_buff_out), .result(mac_out)
    );

    Shift_register shift_reg(
        .inp(mac_out[11:4]), .clk(clk), .shift(shift_reg_en), 
        .final_output(finalize_shift_reg), .outp(mem_data_in)
    );

endmodule