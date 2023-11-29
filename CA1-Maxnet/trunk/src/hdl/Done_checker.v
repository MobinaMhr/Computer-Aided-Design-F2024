// similar to encoder module this module again tells us our maximum number
// the difference is that this module is the logic of it and issues the done signal

module Done_checker(input1, input2, input3, input4, done_signal);

    input input1, input2, input3, input4;
    output done_signal;

    wire w1, w2, w3, w4, w5;

    and(w1, input1, ~input2, ~input3, ~input4);    
    and(w2, ~input1, input2, ~input3, ~input4);    
    and(w3, ~input1, ~input2, input3, ~input4);    
    and(w4, ~input1, ~input2, ~input3, input4);
    and(w5, ~input1, ~input2, ~input3, ~input4);
    or(done_signal, w1, w2, w3, w4, w5); 

endmodule