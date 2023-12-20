// similar to encoder module this module again tells us our maximum number
// the difference is that this module is the logic of it and issues the done signal

module Done_checker(input1, input2, input3, input4, done_signal);

    input input1, input2, input3, input4;
    output done_signal;

    wire w1, w2, w3, w4, w5;

    Bitwise_And bwAnd1({input1, ~input2, ~input3, ~input4}, w1);    
    Bitwise_And bwAnd2({~input1, input2, ~input3, ~input4}, w2);    
    Bitwise_And bwAnd3({~input1, ~input2, input3, ~input4}, w3);    
    Bitwise_And bwAnd4({~input1, ~input2, ~input3, input4}, w4);
    Bitwise_And bwAnd5({~input1, ~input2, ~input3, ~input4}, w5);
    Bitwise_Or bwOr1({w1, w2, w3, w4, w5}, done_signal); 

endmodule