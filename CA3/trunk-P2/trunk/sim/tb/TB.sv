`define N 4
module TB();

    reg clk=1'b0;
    reg rst,start;
    reg [$clog2(`N*16+256)-1:0] x;
    reg [$clog2(`N*16+256)-1:0] y;
    reg [7:0] z;

    wire done;

    CNN #(`N) uut(
        .clk(clk), .rst(rst), .start(start), 
        .x_inp(x), .y_inp(y), .z_inp(z), 
        .done(done)
    );
    
    always begin
        #2 clk = ~clk;
    end

    initial begin
        #1 rst = 1;
        #4 rst = 0;
        x = {{($clog2(`N*16 + 256)-7){1'b0}}, 7'b1000000};
        y = {$clog2(`N * 16 + 256){1'b0}};
        z = 8'd0;
        start = 1;
        #4 start = 0;
        wait(done == 1'b1)
        #20 $stop;
    end

endmodule
