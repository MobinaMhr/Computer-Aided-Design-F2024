module Buffer (W0, W1, W2, W3, W4, W5, W6, W7, W8, W9, W10, W11, W12, W13, W14, W15);
        // Output registers for a 4x4 matrix
        output [31:0] W0, W1, W2, W3;
        output [31:0] W4, W5, W6, W7;
        output [31:0] W8, W9, W10, W11;
        output [31:0] W12, W13, W14, W15;

        // Integer variables for loop indices
        integer k, l;

        // Array to store IEEE 754 floating-point representations
        reg [31:0] buffer [0:15];

        // Initialization block to populate the buffer array
        initial begin
                for (k = 0; k <= 3; k = k + 1) begin
                        for (l = 0; l <= 3; l = l + 1) begin
                                // If k equals l, set the value to 1.0; otherwise, set it to -0.2
                                if (k == l)
                                        buffer[k*4+l] = 32'b00111111100000000000000000000000; // 1.0 in IEEE 754 format
                                else
                                        buffer[k*4+l] = 32'b10111110010011001100110011001101; // -0.2 in IEEE 754 format
                        end
                end
        end

        // Assign values from the buffer array to the output registers
        assign {W0,  W1,  W2,  W3}  = {buffer[0],  buffer[1],  buffer[2],  buffer[3]};
        assign {W4,  W5,  W6,  W7}  = {buffer[4],  buffer[5],  buffer[6],  buffer[7]};
        assign {W8,  W9,  W10, W11} = {buffer[8],  buffer[9],  buffer[10], buffer[11]};
        assign {W12, W13, W14, W15} = {buffer[12], buffer[13], buffer[14], buffer[15]};

endmodule