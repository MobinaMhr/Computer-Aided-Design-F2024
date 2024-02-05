module parametrized_counter #(parameter COUNT) (clk, rst, en, count, cout);

    input clk, rst, en;
    output reg [($clog2(COUNT)-1):0] count;
    output reg cout;

    always @(posedge clk , posedge rst) begin
        if (rst) 
            count <= 0;
        if(en)begin
            if (count == (COUNT))
                count <= 0;
            else
                count <= count + 1;
        end
    end
    assign cout = (count == (COUNT-1));
endmodule

module Controller#(parameter N)(clk, start, write_filter_buff_counter_cout, 
  read_filter_buff_counter_cout, write_main_buff_counter_cout, read_main_buff_counter_cout,rst, 
  load_x, load_y, load_z, write_main_buff_en, read_main_buff_counter_en, write_filter_buff_en,
  write_filter_buff_counter_en, write_window_buff_en, read_filter_buff_counter_en, partial_res_en, 
  write_main_buff_counter_en, shift_main_buff_en, shift_reg_en,
  sel_x, sel_y, sel_z, mem_write_en, done, reset_mac, finalize_shift_reg, mem_addr_sel);
   

  input clk, start;
  input write_filter_buff_counter_cout;
  input read_filter_buff_counter_cout, write_main_buff_counter_cout, read_main_buff_counter_cout,rst;
  output reg load_x, load_y, load_z, write_main_buff_en, read_main_buff_counter_en;
  output reg [0:N-1]write_filter_buff_en;
  output reg write_filter_buff_counter_en, write_window_buff_en, read_filter_buff_counter_en;
  output reg partial_res_en, write_main_buff_counter_en, shift_main_buff_en, shift_reg_en;
  output reg sel_x, sel_y, sel_z, mem_write_en, done, reset_mac, finalize_shift_reg, mem_addr_sel;


   reg shift_reg_counter_en,done_checker_counter_en,main_buff_line_counter_en;
   reg en_kernel;
   reg[1:0] shift_reg_result;
   reg [5:0] done_checker_counter_result;
   reg [1:0] main_buff_line_counter_result;
   reg [($clog2(N)-1):0] kernel_count;

   wire shift_reg_counter_cout,done_checker_counter_cout,main_buff_line_counter_cout,kernel_cout;
   
   parameter [3:0] Idle=4'd0, Init=4'd1, Init_addresses=4'd2, Load_filter=4'd3, Load_main_buff=4'd4,
                        Shift_main_buff=4'd5, Load_window=4'd6, Convolution_calc=4'd7, Shift_reg_write=4'd8,
                                Decision=4'd9, Write_mem=4'd10, Done_checker=4'd11, Load_line_main_buff=4'd12,Done=4'd13,KernelDone=4'd14;

   
   Done_checker_counter done_checker_counter(.clk(clk), .rst(rst), 
                                                .count_en(done_checker_counter_en),
                                                .cout(done_checker_counter_cout), 
                                                .result(done_checker_counter_result));

   Two_bit_counter shift_reg_counter(.clk(clk), .rst(rst), .count_en(shift_reg_counter_en), 
                                        .cout(shift_reg_counter_cout), .result(shift_reg_result));

   Main_buffer_load_counter main_buff_line_counter(.clk(clk), .rst(rst), .count_en(main_buff_line_counter_en),
                                                         .cout(main_buff_line_counter_cout), 
                                                         .result(main_buff_line_counter_result));

   parametrized_counter #(N) KernelCounter(
        .clk(clk), .rst(rst), .en(en_kernel),
        .cout(kernel_cout), .count(kernel_count));

   reg [3:0] ns, ps;

   always @(posedge clk, posedge rst) 
   begin
        if (rst == 1'b1) 
                ps <= Idle;
        else 
                ps <= ns;
   end


   always @(ps, start, write_filter_buff_counter_cout, read_filter_buff_counter_cout, write_main_buff_counter_cout, read_main_buff_counter_cout, shift_reg_counter_cout, done_checker_counter_cout, main_buff_line_counter_cout) begin
           ns = Idle;
           case (ps)
                   Idle : ns = (start) ? Init : Idle;
                   Init : ns = (start) ? Init : Init_addresses;
                   Init_addresses : ns = Load_filter;
                   Load_filter : ns = (write_filter_buff_counter_cout) ? KernelDone : Load_filter;
                   KernelDone : ns = (kernel_cout) ? Load_main_buff : Load_filter;
                   Load_main_buff : ns = (write_main_buff_counter_cout) ? Shift_main_buff : Load_main_buff;
                   Shift_main_buff : ns = (main_buff_line_counter_cout) ? Load_window : Load_main_buff;
                   Load_window : ns = Convolution_calc;
                   Convolution_calc : ns = (read_filter_buff_counter_cout) ? Shift_reg_write : Convolution_calc;
                   Shift_reg_write : ns = Decision;
                   Decision : 
                   begin 
                        if (shift_reg_counter_cout) ns = Write_mem;
                        else if (~shift_reg_counter_cout && read_main_buff_counter_cout) ns = Done_checker;
                        else if (~shift_reg_counter_cout && ~read_main_buff_counter_cout) ns = Load_window;
                   end
                   Write_mem : ns = (read_main_buff_counter_cout) ? Done_checker : Load_window;
                   Done_checker : ns = (done_checker_counter_cout) ? Done : Load_line_main_buff;
                   Load_line_main_buff : ns = (write_main_buff_counter_cout) ? Load_window : Load_line_main_buff;
                   Done : ns = Idle;
                   default: ns = Idle;
           endcase
   end
   always @(ps) begin
           {load_x, load_y, load_z, write_main_buff_en,read_main_buff_counter_en, write_filter_buff_en,
            write_filter_buff_counter_en,write_window_buff_en, read_filter_buff_counter_en,
             partial_res_en,write_main_buff_counter_en, shift_main_buff_en, shift_reg_en,sel_x, sel_y, sel_z,
              mem_write_en, done,mem_addr_sel,shift_reg_counter_en,done_checker_counter_en,main_buff_line_counter_en,reset_mac,
              finalize_shift_reg} = {(22+(N)){1'd0}};
           case(ps) 
                Idle: 
                begin
                        {done} = 1'b1;
                end
                Init_addresses :
                begin
                        {load_x, load_y, load_z, sel_x, sel_y, sel_z} = 6'b111111;
                end                
                Load_filter : 
                begin
                        {mem_addr_sel, load_y} = 2'b11;
                        write_filter_buff_counter_en = 1'b1;
                        write_filter_buff_en[kernel_count] = 1'b1;
                end
                Load_main_buff : 
                begin
                        {mem_addr_sel, write_main_buff_en, write_main_buff_counter_en, load_x} = 4'b0111;
                end        
                KernelDone : 
                begin
                        en_kernel = 1'b1;
                end
                Shift_main_buff : 
                begin
                        {main_buff_line_counter_en} = 1'b1;
                        shift_main_buff_en=(main_buff_line_counter_cout == 1'b0);
                end
                Load_window : 
                begin
                        {write_window_buff_en, read_main_buff_counter_en} = 2'b11;
                end
                Convolution_calc : 
                begin
                        {read_filter_buff_counter_en, partial_res_en} = 2'b11;
                end
                Shift_reg_write : 
                begin
                        {shift_reg_en} = 1'b1;
                end 
                Decision: 
                begin
                        {shift_reg_counter_en, reset_mac} = 2'b11;
                end
                Write_mem :
                begin
                        {mem_write_en, load_z, done_checker_counter_en} = 3'b111;
                end
                Done_checker : 
                begin
                        shift_main_buff_en = (done_checker_counter_cout == 1'b0);
                        {read_main_buff_counter_en} = 1'b1;
                end
                Load_line_main_buff: 
                begin
                        {write_main_buff_en, mem_addr_sel, load_x, write_main_buff_counter_en} = 4'b1011;
                end
                Done: 
                begin
                      {mem_write_en, finalize_shift_reg} = 2'b11;
                end
           endcase
   end
   
endmodule
