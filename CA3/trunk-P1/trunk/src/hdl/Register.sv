module Register #(parameter LENGTH = 8)(inp, load_en, clk, rst, outp);

  input [LENGTH-1:0] inp;
  input load_en, clk, rst;
  output [LENGTH-1:0] outp;

  reg [LENGTH-1:0] mem;
  always @(posedge clk, posedge rst) 
  begin
    if (rst)
      mem <= {LENGTH{1'b0}};
    if (load_en)
      mem <= inp;
  end
  assign outp = mem;

endmodule