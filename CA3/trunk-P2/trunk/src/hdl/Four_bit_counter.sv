module Four_bit_counter(clk, rst, count_en, cout, result);

    input clk, rst, count_en;
    output reg [3:0] result;
    output cout;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            result <= 4'b0000;
        end 
        else if (count_en) begin
            result <= result + 1;
        end
    end

    assign cout = (result == 4'd15 ? 1:0);

endmodule
