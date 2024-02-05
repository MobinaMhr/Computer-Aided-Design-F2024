module Main_buffer (clk, rst, shift_up, write_en, write_data, read_index, write_index, read_data);

    input clk, rst, shift_up, write_en;
    input [7:0] write_data [0:3];
    input [3:0] read_index, write_index;
    
    output reg [7:0] read_data [0:3][0:3];
    
    reg [7:0] main_buff [0:3][0:15];

    always @(posedge clk , posedge rst) begin
        if (rst) begin
            integer i;
            integer j;
            for (i = 0; i < 4; i = i + 1) 
            begin
                for (j = 0; j < 16; j = j + 1) 
                begin
                    main_buff[i][j] <= 8'b0;
                end
            end
        end 
        else begin
            if (write_en == 1'b1) begin
                main_buff[3][write_index] <= write_data[0] ;
                main_buff[3][write_index + 1] <= write_data[1] ;
                main_buff[3][write_index + 2] <= write_data[2] ;
                main_buff[3][write_index + 3] <= write_data[3] ;
            end
            
            if(shift_up) begin
                integer i;
                integer j;
			    for (i = 0; i < 3; i = i + 1) begin
                    for (j = 0; j < 16; j = j + 1) begin
                        main_buff[i][j] <= main_buff[i+1][j];
                    end
                end
		    end
        end

    end

    always @(*) begin
        integer i;
        integer j;
        for (i = 0; i < 4; i = i + 1) begin
            for (j = 0; j < 4; j = j + 1) begin
                read_data[j][i]= main_buff[j][read_index + i]; 
            end
        end
    end

endmodule