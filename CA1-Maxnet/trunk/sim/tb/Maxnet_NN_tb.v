`timescale 1ns/1ps

module Maxnet_NN_tb;

  reg clk, rst, start;
  wire [31:0] maximum_number;
  wire done;

  top_module uut(
    .clock(clk), 
    .reset(rst), 
    .start_signal(start), 
    .output_maximum_number(maximum_number),
    .done(done)
  );

  always begin
    #5 clk = ~clk;
  end

  initial begin
    clk = 0;
    rst = 1;
    start = 0;

    #10 rst = 0;
    #10 start = 1;
    #100 start = 0;
    wait(done == 1'b1)
    #1 $stop;
  end

endmodule