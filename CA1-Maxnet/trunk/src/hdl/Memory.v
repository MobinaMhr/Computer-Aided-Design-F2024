//this module is for reading the first values 

module Memory(clk, rst, read_data1, read_data2, read_data3, read_data4);

    input clk, rst;
    output [31:0] read_data1, read_data2, read_data3, read_data4;

    reg[31:0] mem [0:3];
	
    initial $readmemh("./file/data.dat", mem);

    always@(posedge clk)begin
        if(rst)
            $readmemh("./file/data.dat", mem);
    end

    assign read_data1 = mem[2'b00];
    assign read_data2 = mem[2'b01];
    assign read_data3 = mem[2'b10];
    assign read_data4 = mem[2'b11];

endmodule