// similar to encoder module this module again tells us our maximum number
// the difference is that this module is the logic of it and issues the done signal

module Done_checker(input input1, input2, input3, input4, output done_signal);

    wire not_input1, not_input2, not_input3, not_input4;
    wire w1, w2, w3, w4, w5;

    NOT not1(input1, not_input1);
    NOT not2(input2, not_input2);
    NOT not3(input3, not_input3);
    NOT not4(input4, not_input4);

    AND4 bwAnd1(input1, not_input2, not_input3, not_input4, w1);
    AND4 bwAnd2(not_input1, input2, not_input3, not_input4, w2);  
    AND4 bwAnd3(not_input1, not_input2, input3, not_input4, w3);    
    AND4 bwAnd4(not_input1, not_input2, not_input3, input4, w4);
    AND4 bwAnd5(not_input1, not_input2, not_input3, not_input4, w5);

    Five_bit_or bwOr1({w1, w2, w3, w4, w5}, done_signal); 

endmodule