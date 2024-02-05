module Write_memory #(parameter CAPACITY, NUM, string FILE_NAME) (clk, write_en, done, addr, inp);

    input clk, write_en, done; 
    input [$clog2(CAPACITY)-1:0] addr;
    input [7:0] inp [0:3];

    reg [31:0] data_mem [0:CAPACITY-1];
    reg [63:0] hexadecimal_char;

    always @(done) begin
        if (done) begin
            integer loop_index;
            integer output_file;
		    output_file = $fopen($sformatf(FILE_NAME, NUM), "w");
		    // output_file = $fopen($sformatf("./../../sim/file/outputs/output%0d.txt", NUM), "w");

            if (output_file == 0) begin
                $fatal("Error opening output file: ./../sim/file/outputs/output%0d.txt", NUM);
            end

   	 	    for (loop_index = 0; loop_index < 25; loop_index = loop_index + 1) begin
                $sformat(hexadecimal_char, "%h", data_mem[loop_index]); 
                $fwrite(output_file, "%s\n", hexadecimal_char);
    	    end

    	    $fclose(output_file);
  	    end
    end

    always @(posedge clk) begin
        if (write_en) begin
            data_mem[(addr >> 2)] <= {inp[0],inp[1],inp[2],inp[3]};
        end
    end
endmodule
