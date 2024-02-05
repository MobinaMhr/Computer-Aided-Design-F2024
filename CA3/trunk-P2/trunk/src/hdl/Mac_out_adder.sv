module Mac_out_adder #(parameter N) (macs_output, add_out);

    input [11:0] macs_output [0:N-1];
    
    output [7:0] add_out;

    reg [13:0] sum;
    
    always @(*) begin
        sum = 0;
        for(integer i=0; i<N; i=i+1) begin
            sum = sum + {macs_output[i]};
        end
    end
    
    assign add_out = sum[11:4];

endmodule
