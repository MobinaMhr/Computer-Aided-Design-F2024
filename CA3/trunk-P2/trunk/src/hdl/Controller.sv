module Controller#(parameter N)(clk, start, write_filter_buff_counter_cout, 
    read_filter_buff_counter_cout, write_main_buff_counter_cout, read_main_buff_counter_cout,rst, 
    load_x, load_y, load_z, write_main_buff_en, read_main_buff_counter_en, write_filter_buff_en,
    write_filter_buff_counter_en, write_window_buff_en, read_filter_buff_counter_en, partial_res_en, 
    write_main_buff_counter_en, shift_main_buff_en, shift_reg_en,
    sel_x, sel_y, sel_z, mem_write_en, done, reset_mac, finalize_shift_reg, mem_addr_sel, FL_OFM_addr_sel);
     
    input clk, start;
    input write_filter_buff_counter_cout;
    input read_filter_buff_counter_cout, write_main_buff_counter_cout, read_main_buff_counter_cout,rst;

    output reg load_x, load_y, load_z, write_main_buff_en, read_main_buff_counter_en;
    output reg [0:N-1]write_filter_buff_en;
    output reg write_filter_buff_counter_en, write_window_buff_en, read_filter_buff_counter_en;
    output reg partial_res_en, write_main_buff_counter_en, shift_main_buff_en, shift_reg_en;
    output reg sel_x, sel_y, sel_z, mem_write_en, done, reset_mac, finalize_shift_reg, mem_addr_sel, FL_OFM_addr_sel;

    reg shift_reg_counter_en,done_checker_counter_en,main_buff_line_counter_en;
    reg en_kernel;
    reg [1:0] shift_reg_result;
    reg [5:0] done_checker_counter_result;
    reg [1:0] main_buff_line_counter_result;
    reg [($clog2(N)-1):0] kernel_count;

    wire shift_reg_counter_cout,done_checker_counter_cout,main_buff_line_counter_cout,kernel_cout;
     
    parameter [3:0] Idle = 4'd0;
    parameter [3:0] Init = 4'd1; 
    parameter [3:0] Init_addres = 4'd2; 
    parameter [3:0] Ld_filter = 4'd3; 
    parameter [3:0] Ld_main_buff = 4'd4;
    parameter [3:0] Shift_main_buff = 4'd5; 
    parameter [3:0] Ld_window = 4'd6; 
    parameter [3:0] Convolution_calc = 4'd7; 
    parameter [3:0] Shiftreg_write = 4'd8;
    parameter [3:0] Decision = 4'd9; 
    parameter [3:0] Write_mem = 4'd10; 
    parameter [3:0] Done_checker = 4'd11; 
    parameter [3:0] Ld_line_main_buff = 4'd12;
    parameter [3:0] Pre_Done = 4'd13;
    parameter [3:0] Kernel_Done = 4'd14; 
    parameter [3:0] Final_DONE = 4'd15;

    Done_checker_counter done_checker_counter(
        .clk(clk), .rst(rst), 
        .count_en(done_checker_counter_en),
        .cout(done_checker_counter_cout), 
        .result(done_checker_counter_result)
    );

    Two_bit_counter shift_reg_counter(
        .clk(clk), .rst(rst), .count_en(shift_reg_counter_en), 
        .cout(shift_reg_counter_cout), .result(shift_reg_result)
    );

    Main_buffer_load_counter main_buff_line_counter(
        .clk(clk), .rst(rst), .count_en(main_buff_line_counter_en),
        .cout(main_buff_line_counter_cout), 
        .result(main_buff_line_counter_result)
    );

    Parametrized_counter #(N) KernelCounter(
        .clk(clk), .rst(rst), .en(en_kernel),
        .cout(kernel_cout), .count(kernel_count)
    );

    reg [3:0] ns, ps;

    always @(posedge clk, posedge rst) begin
        if (rst == 1'b1) 
            ps <= Idle;
        else 
            ps <= ns;
    end


    always @(ps, start, write_filter_buff_counter_cout, read_filter_buff_counter_cout, 
                write_main_buff_counter_cout, read_main_buff_counter_cout, shift_reg_counter_cout, 
                done_checker_counter_cout, main_buff_line_counter_cout) begin

        ns = Idle;
        case (ps)
            Idle                : ns = (start) ? Init : Idle;
            Init                : ns = (start) ? Init : Init_addres;
            Init_addres         : ns = Ld_filter;
            Ld_filter           : ns = (write_filter_buff_counter_cout) ? Kernel_Done : Ld_filter;
            Kernel_Done         : ns = (kernel_cout) ? Ld_main_buff : Ld_filter;
            Ld_main_buff        : ns = (write_main_buff_counter_cout) ? Shift_main_buff : Ld_main_buff;
            Shift_main_buff     : ns = (main_buff_line_counter_cout) ? Ld_window : Ld_main_buff;
            Ld_window           : ns = Convolution_calc;
            Convolution_calc    : ns = (read_filter_buff_counter_cout) ? Shiftreg_write : Convolution_calc;
            Shiftreg_write      : ns = Decision;
            Decision : begin 
                if (shift_reg_counter_cout)                                         ns = Write_mem;
                else if (~shift_reg_counter_cout && read_main_buff_counter_cout)    ns = Done_checker;
                else if (~shift_reg_counter_cout && ~read_main_buff_counter_cout)   ns = Ld_window;
            end
            Write_mem           : ns = (read_main_buff_counter_cout) ? Done_checker : Ld_window;
            Done_checker        : ns = (done_checker_counter_cout) ? Pre_Done : Ld_line_main_buff;
            Ld_line_main_buff   : ns = (write_main_buff_counter_cout) ? Ld_window : Ld_line_main_buff;
            Pre_Done            : ns = Final_DONE;
            Final_DONE          : ns = Idle;

            default: ns = Idle;
        endcase
    end

    always @(ps) begin
        {load_x, load_y, load_z, write_main_buff_en,read_main_buff_counter_en, write_filter_buff_en,
            write_filter_buff_counter_en,write_window_buff_en, read_filter_buff_counter_en,
            partial_res_en,write_main_buff_counter_en, shift_main_buff_en, shift_reg_en,sel_x, sel_y, sel_z,
            mem_write_en, done,mem_addr_sel, shift_reg_counter_en, done_checker_counter_en, 
            main_buff_line_counter_en, reset_mac, finalize_shift_reg, FL_OFM_addr_sel} = {(23+(N)){1'd0}};
        case(ps) 
            Init_addres : begin
                {load_x, load_y, load_z, sel_x, sel_y, sel_z} = 6'b111111;
            end

            Ld_filter : begin
                mem_addr_sel = 1'b1;
                load_y = 1'b1;
                write_filter_buff_counter_en = 1'b1;
                write_filter_buff_en[kernel_count] = 1'b1;
            end

            Ld_main_buff : begin
                {mem_addr_sel, write_main_buff_en, write_main_buff_counter_en, load_x} = 4'b0111;
            end                

            Kernel_Done : begin
                en_kernel = 1'b1;
            end

            Shift_main_buff : begin
                {main_buff_line_counter_en} = 1'b1;
                shift_main_buff_en=(main_buff_line_counter_cout == 1'b0);
            end

            Ld_window : begin
                {write_window_buff_en, read_main_buff_counter_en} = 2'b11;
            end

            Convolution_calc : begin
                {read_filter_buff_counter_en, partial_res_en} = 2'b11;
            end

            Shiftreg_write : begin
                {shift_reg_en} = 1'b1;
            end 

            Decision: begin
                {shift_reg_counter_en, reset_mac} = 2'b11;
            end

            Write_mem : begin
                {mem_write_en, load_z, done_checker_counter_en, FL_OFM_addr_sel} = 4'b1111;
            end

            Done_checker : begin
                shift_main_buff_en = (done_checker_counter_cout == 1'b0);
                {read_main_buff_counter_en} = 1'b1;
            end

            Ld_line_main_buff: begin
                {write_main_buff_en, mem_addr_sel, load_x, write_main_buff_counter_en} = 4'b1011;
            end

            Pre_Done: begin
                {mem_write_en, finalize_shift_reg, FL_OFM_addr_sel} = 3'b111;
            end

            Final_DONE: begin
                {done} = 1'b1;
            end
        endcase
    end
     
endmodule
