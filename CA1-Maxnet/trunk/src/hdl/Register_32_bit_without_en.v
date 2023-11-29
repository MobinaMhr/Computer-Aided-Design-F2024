// this register is without enable or load signal
// it has a asynchornous reset

module Register32_w(input_data, clock, reset, output_data);
    input [31:0] input_data;
    input clock, reset;
    output reg [31:0] output_data;

    always @(posedge clock, posedge reset) begin
        if (reset) 
            output_data <= 32'b0;
        else 
            output_data <= input_data;
    end
endmodule