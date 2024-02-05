module PC #(parameter NO_BITS) (clk, rst, sel, increas_en, init_pc, address);
    
    input clk, rst, sel, increas_en;
    input[NO_BITS-1:0] init_pc;

    output [NO_BITS-1:0] address;

    wire [NO_BITS-1:0] mux_result, reg_out, add_result;

    Adder #(NO_BITS)address_adder(
        .inp_one({{(NO_BITS-3){1'b0}}, 3'b100}), 
        .inp_two(reg_out), 
        .result(add_result)
    );

    Two_to_one_mux #(NO_BITS) Mux(
        .sel(sel), 
        .input_one(add_result), 
        .input_two(init_pc), 
        .outp(mux_result)
    );

    Register #(NO_BITS) address_reg(
        .inp(mux_result), 
        .load_en(increas_en), 
        .clk(clk), 
        .rst(rst), 
        .outp(reg_out)
    );
    
    assign address = reg_out;
    
endmodule
