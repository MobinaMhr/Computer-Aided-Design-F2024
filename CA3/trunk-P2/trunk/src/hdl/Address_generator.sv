module Address_generator (clk, rst, en_window_startpos_cntr, en_line_cntr, addr, cout_addr_generator, ld_window_done);

    input clk, rst, en_window_startpos_cntr, en_line_cntr;

    output [$clog2(172)-1:0] addr;
    output cout_addr_generator, ld_window_done;

    wire cout_i_cntr, cout_j_cntr, cout_line_cntr;
    wire [$clog2(10)-1:0] count_i, count_j;
    wire [1:0] count_line;

    Parametrized_counter #(10) Count_i (
        .clk(clk), 
        .rst(rst), 
        .en(cout_j_cntr & en_window_startpos_cntr), 
        .count(count_i), .cout(cout_i_cntr)
    );

    Parametrized_counter #(10) Count_j (
        .clk(clk), 
        .rst(rst), 
        .en(en_window_startpos_cntr),                  
        .count(count_j), .cout(cout_j_cntr)
    );

    Two_bit_counter CountLine(
        .clk(clk), 
        .rst(rst), 
        .count_en(en_line_cntr), 
        .cout(cout_line_cntr), 
        .result(count_line)
    );

    assign addr = (13 * (count_i + count_line)) + count_j ;
    assign cout_addr_generator = cout_line_cntr;
    assign ld_window_done = cout_i_cntr & cout_j_cntr;

endmodule
