module OFM_memory #(parameter CAPACITY, NUM, FILE_NAME) (clk, w_en, done, addr, inp, d_out);

    input clk, w_en, done;
    input [$clog2(CAPACITY)-1:0] addr;
    input [7:0] inp [0:3];

    output reg [7:0] d_out [0:3];

    reg [7:0] d_mem [0:CAPACITY - 1];
    always @(posedge clk) begin
        if (w_en) begin
            d_mem[(addr) + 0] <= inp[0];
            d_mem[(addr) + 1] <= inp[1];
            d_mem[(addr) + 2] <= inp[2];
            d_mem[(addr) + 3] <= inp[3];
        end    
    end

    reg [63:0] hex_string;
    always @(done) begin
        if (done) begin
            integer index, output_fd;

		    output_fd = $fopen($sformatf(FILE_NAME, NUM), "w");

   	 	    for (index = 0; index < 43; index = index + 1) begin
                $sformat(hex_string, "%h", {d_mem[(4*index)], d_mem[(4*index)+1], 
                            d_mem[(4*index)+2], d_mem[(4*index)+3]}); 
                $fwrite(output_fd, "%s\n", hex_string);
            end

            $fclose(output_fd); 
  	    end
    end

    assign d_out[3] = d_mem [(addr + 3)];
    assign d_out[2] = d_mem [(addr + 2)];
    assign d_out[1] = d_mem [(addr + 1)];
    assign d_out[0] = d_mem [(addr + 0)];

endmodule