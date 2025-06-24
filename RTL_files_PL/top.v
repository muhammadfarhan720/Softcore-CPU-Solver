
module top( 
   input         CLOCK_50,                             // 50 MHz clock
   input   [3:0] KEY,                                  // The four active-low pushbuttons on the DE1
	input   [9:0] SW,                                   // The ten slider switches on the DE1
	output  [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0,   // The six hex displays on the DE1
   output  [9:0] LED                                   // The ten red LEDs on the DE1
);

// -----------------
// Wire declarations
// -----------------
	wire   [31:0] x;        // Solver input value
	wire          start;    // Asserted to start the computation
	wire   [31:0] result;   // Solution 
   wire          done;     // Asserted when the computation is finished
	wire   [31:0] data;		// A result stored in the monitor

// ----------------------------------
// THIS IS AN INSTANCE OF YOUR SOLVER
// ----------------------------------

	solver u0(
	   .clk_clk         (CLOCK_50),   // clk.clk
		.reset_reset_n   (KEY[0]),     // reset.reset_n
		.x_export        (x),          // x.export (input)
		.start_export    (start),      // start.export (input)
		.result_export   (result),     // result.export (output)
		.done_export     (done)        // done.export (output)
   );

// --------------------------------------------
// THIS IS AN INSTANCE OF THE MONITOR PROCESSOR
// --------------------------------------------

	monitor u1(
		.clk					(CLOCK_50),			// System clock (input)
		.reset_n				(KEY[0]),			// reset_n (input)
		.done					(done),				// done from the solver (input)
		.address				(SW[3:0]),			// Recorded result index (input)
		.result				(result),			// result_out from the solver (input)
		.start				(start),     		// start (output)
		.x						(x),          		// x (output)
		.data					(data)				// Recorded result (output)
	);

// -----------------
// Handshake signals
// -----------------

	hex_displays h1(data[31:8], HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
   assign LED = {done, 1'b0, data[7:0]};

endmodule
