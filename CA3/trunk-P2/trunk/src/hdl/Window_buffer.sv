module Window_buffer(inp, load, clk, rst, index, outp);

    input [7:0] inp[0:3][0:3];
    input load, clk, rst;
    input [3:0] index;
    
    output [7:0] outp;

    reg [7:0] window [0:15];

    always @(posedge clk,posedge rst) begin
        if (rst) begin
            integer k;
            for (k = 0; k < 16; k = k + 1) begin
                    window[k]=8'd0;
            end
        end
        if (load) begin
            integer i;
            integer j;
            for (i = 0; i < 4; i = i + 1) begin
                for (j = 0; j < 4; j = j + 1) begin
                    window[4*i+j] = inp[i][j]; 
                end
            end
        end
    end

    assign outp = window[index];

endmodule