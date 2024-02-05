module Up_12_counter(clk, rst, count_en, cout, result);

    input clk, rst, count_en;
    output cout;
    output reg [3:0] result;

    always @(posedge clk or posedge rst) 
    begin
        if (rst) 
        begin
            result <= 4'd0;
        end else if (count_en) 
        begin
            if (result == 4'b1101) 
            begin
                result <= 4'd0;
            end else 
            begin
                result <= result + 1;
            end
        end
    end
    assign cout = (result == 4'b1101);

endmodule
