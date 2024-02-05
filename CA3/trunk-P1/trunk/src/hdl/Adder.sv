module Adder #(parameter LENGTH)(inp_one, inp_two, result);

    input [LENGTH-1:0] inp_one, inp_two;
    output [LENGTH-1:0] result;

    wire carry;
    assign {carry, result} = inp_one + inp_two;
    
endmodule
