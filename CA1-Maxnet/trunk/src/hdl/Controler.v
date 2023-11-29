`define Idle 0
`define Init 1
`define Mul 2
`define Add 3
`define Update 4
`define Done 5

module controller(done, start, clk, rst, load_x, load_t, select_t);

	input done, start, clk, rst;
	output reg load_x, load_t, select_t;
	reg[2:0] ns, ps;
	
	//this always block is for synchornized state change
	always@(posedge clk)begin
		if (rst) ps = `Idle;
		else ps <= ns;
	end

	//this always block is for issuing signals at specific states
	always@(ps)begin
		{load_x, load_t, select_t} = 3'b000;
		case(ps)
		    `Init: begin 
			load_x = 1'b1; load_t = 1'b1; select_t = 1'b1; 
		    end
		    `Update: begin 
			load_t = 1'b1;
		    end
		endcase
	end

	//this always block is for determining the next states
	always@(ps, done, start, clk, rst)begin
	    case(ps)
		`Idle: ns = (start) ? `Init: `Idle;
		`Init: ns = (start) ? `Init: `Mul;
		`Mul: ns = `Add;
		`Add: ns = `Update;
		`Update: ns = (done) ? `Done: `Mul;
		`Done: ns = `Idle;
	    endcase
	end

endmodule