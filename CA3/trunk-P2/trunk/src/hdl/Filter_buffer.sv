module Filter_buffer(inp, load, clk, rst, index, write_address, outp);

    input [7:0] inp[0:3];
    input load, clk, rst;
    input [3:0] index;
    input [3:0] write_address;
    output [7:0] outp;

    reg [7:0] filter [0:15];
    always @(posedge clk,posedge rst) begin
        if (rst) begin
            integer k;
            for (k = 0; k < 16; k = k + 1) begin
                    filter[k]=8'd0;
            end
        end
        if (load) begin
            filter[write_address] <= inp[0];
            filter[write_address + 4'd1] <= inp[1];
            filter[write_address + 4'd2] <= inp[2];
            filter[write_address + 4'd3] <= inp[3];
        end
    end
    assign outp = filter[index];

endmodule