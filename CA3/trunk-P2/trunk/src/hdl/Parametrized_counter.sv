module Parametrized_counter #(parameter COUNT) (clk, rst, en, count, cout);

    input clk, rst, en;
    
    output reg [($clog2(COUNT)-1):0] count;
    output reg cout;

    always @(posedge clk , posedge rst) begin
        if (rst) begin
            count <= 0;
        end
        else if (en) begin
            count <= (count == (COUNT-1)) ? 0 : count + 1;
        end
    end
    
    assign cout = (count == (COUNT-1));

endmodule