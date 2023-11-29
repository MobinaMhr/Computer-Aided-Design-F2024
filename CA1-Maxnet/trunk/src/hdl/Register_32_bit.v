//this register is with load signal that whenever is 1 it loads its input to output
// it has a asynchornous reset

module Register32(input_data, load, clock, reset, output_data);
    input [31:0] input_data;
    input load, clock, reset;
    output reg [31:0] output_data;

    always @(posedge clock, posedge reset)begin
        if (reset) 
            output_data <= 32'b0;
        else if (load) 
            output_data <= input_data;
    end
endmodule