module SL_Controller #(parameter N)(clk, rst, start, read_window_filter_cntr_cout, 
                                    write_filter_buff_cntr_cout, write_filter_buff_en, 
                                    ld_filters_pc, write_filter_buff_cntr_en, 
                                    write_window_buff_en, sel_mem, read_window_filter_cntr_en, 
                                    partial_res_en, shiftreg_en, rst_mac, done, mem_write_en, 
                                    ld_z_prime, addr_gen_windowpos_cntr_en, addr_gen_line_cntr_en,
                                    cout_addr_generator, ld_window_done);

    input clk, rst, start, read_window_filter_cntr_cout;
    input write_filter_buff_cntr_cout, cout_addr_generator, ld_window_done;

    output reg [0:N-1] write_filter_buff_en;
    output reg ld_filters_pc, write_filter_buff_cntr_en, write_window_buff_en, sel_mem;
    output reg read_window_filter_cntr_en, partial_res_en, shiftreg_en, rst_mac, done;
    output reg mem_write_en, ld_z_prime, addr_gen_windowpos_cntr_en, addr_gen_line_cntr_en;

    reg en_kernel, en_shift;
    reg [($clog2(N)-1):0] kernel_count;
    reg [1:0] shift_count;

    wire kernel_cout, shift_cout;

    parameter [3:0] Idle=4'd0;
    parameter [3:0] Filter_Ld=4'd1; 
    parameter [3:0] Window_Ld=4'd2; 
    parameter [3:0] Mac=4'd3; 
    parameter [3:0] ShiftReg=4'd4; 
    parameter [3:0] Decide=4'd5; 
    parameter [3:0] Mem_Write=4'd6; 
    parameter [3:0] Done=4'd7; 
    parameter [3:0] Filter_Ld_Done=4'd8;

    Two_bit_counter ShiftCount(
        .clk(clk), .rst(rst), .count_en(en_shift),
        .cout(shift_cout), .result(shift_count)
    );

    Parametrized_counter #(N) KernelCounter(
        .clk(clk), .rst(rst), .en(en_kernel),
        .cout(kernel_cout), .count(kernel_count)
    );

    reg [3:0] ns, ps;
    always @(ps, start, write_filter_buff_cntr_cout, read_window_filter_cntr_cout, 
                kernel_cout, shift_cout, ld_window_done, cout_addr_generator) begin
        ns = Idle;
        case (ps)
            Idle            : ns = (start) ? Filter_Ld : Idle;
            Filter_Ld       : ns = (write_filter_buff_cntr_cout) ? Filter_Ld_Done : Filter_Ld;
            Filter_Ld_Done  : ns = (kernel_cout) ? Window_Ld : Filter_Ld;
            Window_Ld       : ns = (cout_addr_generator) ? Mac : Window_Ld;
            Mac             : ns = (read_window_filter_cntr_cout) ? ShiftReg : Mac;
            ShiftReg        : ns = Decide;
            Decide          : ns = (shift_cout) ? Mem_Write : Window_Ld;
            Mem_Write       : ns = (ld_window_done) ? Done : Window_Ld;
            Done            : ns = Idle;
            default:          ns = Idle;
        endcase
    end
   
    always @(ps) begin
        {write_filter_buff_en, ld_filters_pc, write_filter_buff_cntr_en, write_window_buff_en, 
        addr_gen_line_cntr_en, sel_mem,read_window_filter_cntr_en, partial_res_en, shiftreg_en, 
        addr_gen_windowpos_cntr_en,en_shift,rst_mac,mem_write_en, ld_z_prime, done} = {(13+(N)){1'b0}};

        case(ps) 
        Filter_Ld : begin
            ld_filters_pc = 1'b1;
            write_filter_buff_cntr_en = 1'b1;
            write_filter_buff_en[kernel_count] = 1'b1;
        end

        Filter_Ld_Done : begin
            en_kernel = 1'b1;
        end

        Window_Ld : begin
            write_window_buff_en = 1'b1;
            addr_gen_line_cntr_en = 1'b1;
            sel_mem = 1'b1;
        end

        Mac : begin
            read_window_filter_cntr_en = 1'b1;
            partial_res_en = 1'b1;
        end

        ShiftReg : begin
            shiftreg_en = 1'b1;
        end

        Decide: begin
            en_shift = 1'b1;
            rst_mac = 1'b1;
            addr_gen_windowpos_cntr_en = (~shift_cout);
        end

        Mem_Write : begin
            mem_write_en = 1'b1;
            ld_z_prime = 1'b1;
            addr_gen_windowpos_cntr_en = 1'b1;
        end

        Done:begin
            done = 1'b1;
        end
        endcase
    end

    always @(posedge clk, posedge rst) begin
        if (rst == 1'b1) begin
            ps <= Idle;
        end
        else begin
            ps <= ns;
        end
    end

endmodule
