module Filter_memory #(parameter CAPACITY, NO_BITS, FILE_NAME) (clk, done, addr, outp);

    input clk, done;
    input[NO_BITS-1:0] addr;
    output [7:0] outp [0:3];

    reg [31:0] data_mem [0:CAPACITY - 1];     
    initial 
    begin
        // $readmemh ("./../../sim/file/input.txt ", data_mem);
        $readmemh ($sformatf("filter%d_L2.txt", NUM), data_mem);
    end

    assign outp[3] = data_mem [(addr >> 2)][7:0];
    assign outp[2] = data_mem [(addr >> 2)][15:8];
    assign outp[1] = data_mem [(addr >> 2)][23:16];
    assign outp[0] = data_mem [(addr >> 2)][31:24];

endmodule