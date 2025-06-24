

module monitor(
	input             clk,
	input             reset_n,
	input             done,
	input       [3:0] address,
	input		  [31:0] result,
	output reg        start,
	output	  [31:0]	x,
	output     [31:0] data      
);

	reg 	      [3:0] state;				// State vector for FSM
	reg        [31:0] runtime;				// Cycle counter - time taken to compute
	reg         [5:0] count;				// Determines which test currently active
	reg 	     [31:0] results [0:15];	// The results produced by DUT
   reg 	     [31:0] stimulus;			// The actual stimulus pattern used
	
// Define state bindings:
	localparam sIDLE = 0, sSTART = 1, sWAIT1 = 2, sWAIT2 = 3, sDONE = 4;

// Define the maximum number of states:
	localparam MAXTEST = 15;
	
// This is the FSM that controls the test.
	always@(posedge clk) begin
		if(reset_n == 1'b0) begin
			start   <= 1'b0;
			state   <= sIDLE;
			runtime <= 32'd0;
			count   <= 6'd0;
		end
		else begin
			case(state) 
			// Default initial state
				sIDLE: begin
					if(done == 1'b1)
						state <= sSTART;
				end
			// This state produces a start pulse for the DUT
				sSTART: begin
					start <= 1'b1;
					state <= sWAIT1;
				end
			// Waiting for the results, Part 1
				sWAIT1: begin
					if(done == 1'b0) begin
						start   <= 1'b0;
						runtime <= runtime + 32'd1;
						state   <= sWAIT2;
					end
				end
			// Waiting for the results, Part 2: Capture the answer
				sWAIT2: begin
					runtime <= runtime + 32'd1;
					if(done == 1'b1) begin 
						results[count] <= result;
						state          <= sDONE;
					end
				end
				// Finalize things and prepare to do it again if needed
				sDONE: begin
					if(count < MAXTEST) begin
						count <= count + 6'd1;
						state <= sIDLE;
					end
					else begin
						results[15] <= runtime;
					end
				end
            default: state <= sIDLE;
			endcase
		end
	end
	
	// This is a behavioral model of a ROM for the stimulus values:
	always@(count) begin
		case(count)
			4'h0:    stimulus = 32'hbf666666;   // x = -0.9
			4'h1:    stimulus = 32'hbf333333;   // x = -0.7
			4'h2:    stimulus = 32'hbf000000;   // x = -0.5
			4'h3:    stimulus = 32'hbecccccd;   // x = -0.4
			4'h4:    stimulus = 32'hbe99999a;   // x = -0.3
			4'h5:    stimulus = 32'hbe4ccccd;   // x = -0.2
			4'h6:    stimulus = 32'hbdcccccd;   // x = -0.1
			4'h7:    stimulus = 32'h00000000;   // x = 0
			4'h8:    stimulus = 32'h3dcccccd;   // x = 0.1
			4'h9:    stimulus = 32'h3e4ccccd;   // x = 0.2
			4'ha:    stimulus = 32'h3e99999a;   // x = 0.3
			4'hb:    stimulus = 32'h3ecccccd;   // x = 0.4
			4'hc:    stimulus = 32'h3f000000;   // x = 0.5
			4'hd:    stimulus = 32'h3f333333;   // x = 0.7
			4'he:    stimulus = 32'h3f666666;   // x = 0.9
			default: stimulus = 32'hffffffff;				
		endcase
	end
	
//	assign start = (state == sWAIT1); 
	assign x     = stimulus;
	assign data  = results[address];

endmodule
