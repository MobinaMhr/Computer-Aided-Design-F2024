module First_layer #(parameter N) (clk, rst, start, x_inp, y_inp, z_inp, done, z_out, mem_data_in, mem_write_en, FL_OFM_addr_sel);

    input clk, rst, start;
    input[$clog2(N*16+256)-1:0] x_inp, y_inp;
    input[7:0] z_inp;
    output done;
    output mem_write_en, FL_OFM_addr_sel;
    output[7:0] z_out;
    output[7:0] mem_data_in[0:N-1][0:3];

    wire sel1, sel2, sel3;
    wire cout1, cout2, cout3, cout4;
    wire en1, en2, en3, en4;
    wire[0:N-1] en6;
    wire en7, en8, en9, en10, en11, en12, en13;
    wire sel4;
    wire clc_mac , finalize_shift_reg, shift_buff, temp_done;
    


    Datapath #(N)dPath(
        .clk(clk), .rst(rst), .load_x(en1), .sel_x(sel1), .load_y(en2), .sel_y(sel2), .load_z(en3), .sel_z(sel3),
        .write_main_buff_counter_en(en12), .read_main_buff_counter_en(en13), .shift_main_buff_en(shift_buff), .write_main_buff_en(en4),
        .write_filter_buff_counter_en(en7), .read_filter_buff_counter_en(en9), .write_filter_buff_en(en6),
        .partial_res_en(en10), .shift_reg_en(en11), .reset_mac(clc_mac),
        .finalize_shift_reg(finalize_shift_reg), .done(temp_done),
        .mem_addr_sel(sel4), .x_inp(x_inp), .y_inp(y_inp), .z_inp(z_inp), .write_filter_buff_counter_cout(cout3), 
        .read_filter_buff_counter_cout(cout4), .write_main_buff_counter_cout(cout2), .read_main_buff_counter_cout(cout1),
        .write_window_buff_en(en8), .z_out(z_out), .mem_data_in(mem_data_in)
    );

    Controller #(N) ctrlr(
        .clk(clk), .start(start), .write_filter_buff_counter_cout(cout3), .read_filter_buff_counter_cout(cout4),
        .write_main_buff_counter_cout(cout2), .read_main_buff_counter_cout(cout1), .rst(rst), 
        .load_x(en1), .load_y(en2), .load_z(en3), .write_main_buff_en(en4),
        .read_main_buff_counter_en(en13), .write_filter_buff_en(en6), .write_filter_buff_counter_en(en7),
        .write_window_buff_en(en8), .read_filter_buff_counter_en(en9), .partial_res_en(en10),
        .write_main_buff_counter_en(en12), .shift_main_buff_en(shift_buff), .shift_reg_en(en11),
        .sel_x(sel1), .sel_y(sel2), .sel_z(sel3), .mem_write_en(mem_write_en), .done(temp_done), .reset_mac(clc_mac),
        .finalize_shift_reg(finalize_shift_reg), .mem_addr_sel(sel4), .FL_OFM_addr_sel(FL_OFM_addr_sel)
    );

    assign done = temp_done;

endmodule
