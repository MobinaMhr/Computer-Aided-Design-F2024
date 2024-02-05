module Two_bit_counter(clk, rst, count_en, cout, result);

    input clk, rst, count_en;
    
    output cout;
    output reg [1:0] result;

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            result <= 2'b00;
        end 
        else if (count_en) begin
            result <= result + 1;
        end
    end

    assign cout = (result == 2'b11 ? 1 : 0);

endmodule
