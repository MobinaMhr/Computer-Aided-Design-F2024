module Done_checker_counter(clk, rst, count_en, cout, result);

    input clk, rst, count_en;
    output cout;
    output reg [5:0] result;

    always @(posedge clk , posedge rst) begin
        if (rst) begin
            result <= 0;
        end 
        else begin
            if (count_en) result <= result + 1;
        end
    end
    
    assign cout = (result == 6'd42 ? 1 : 0);

endmodule