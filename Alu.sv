module Alu (
	input clk,
	input [2:0] op,
	input [7:0] reg_val,
	input [7:0] stack0,
	input [7:0] stack1,
	output [7:0] reg_out,
	output [7:0] stack0_out,
	output [7:0] stack1_out,
	output bit branch_sig
	);
	import definitions::*;	// alu ops
	bit overflow; // from and for adding

	// temp registers
	logic [8:0] true_add; // add
	logic [7:0] temp_shift; // and and shift
	logic [7:0] stack1_out0; // and and shift

	// options for muxes
	logic [7:0] reg_out0; // add
	logic [7:0] reg_out1; // inc
	logic [7:0] reg_out2; // add overflow
	logic [7:0] reg_out3; // sub
	logic [7:0] reg_out4; // abs
	
	logic [7:0] stack0_out0; // and and shift
	logic [7:0] stack0_out1; // abs
	
	bit branch_sig0; // blt
	bit branch_sig1; // contains
	
	
	always_comb begin
		/* add */
		true_add = stack0 + stack1;
		overflow = true_add[8];
		reg_out0 = true_add[7:0];
		
		/* blt */
		if (stack0 < stack1) branch_sig0 = 1'b1;
		else branch_sig0 = 1'b0;
		
		/* inc */
		reg_out1 = reg_val + 1;
		
		/* and and shift */
		temp_shift = (stack1 >> reg_val) & stack0;
		stack1_out0 = temp_shift >> (8-reg_val);
		stack0_out0 = temp_shift << reg_val;
		
		/* add overflow */
		reg_out2 <= overflow + stack0 + reg_val;
	
		/* contains */
		branch_sig1 <=  (!((stack0 & 8'b00001111) ^ stack1)) |
				(!((stack0 & 8'b00011110 >> 1) ^ stack1)) |
				(!((stack0 & 8'b00111100 >> 2) ^ stack1)) |
				(!((stack0 & 8'b01111000 >> 3) ^ stack1)) |
				(!((stack0 & 8'b11110000 >> 4) ^ stack1));
	
		/* sub */
		reg_out3 <= stack0 - stack1;
	
		/* abs */
		reg_out4 <= reg_val[7] ? -reg_val : reg_val;
		stack0_out1 <= reg_val[7] ? -reg_val : reg_val;
		
	end
	
	// final muxes
	
	assign reg_out =    (op == ADD) ? reg_out0 :
			    (op == INC) ? reg_out1 :
			    (op == AOV) ? reg_out2 :
			    (op == SUB) ? reg_out3 :
			    (op == ABS) ? reg_out4 : 
					  8'bx; // don't care
	
	assign stack0_out = (op == AAS) ? stack0_out0 :
			    (op == ABS) ? stack0_out1 : 
					  8'bx;
	assign branch_sig = (op == BLT) ? branch_sig0 :
			    (op == CON) ? branch_sig1 : 
					  8'bx;
	assign stack1_out = stack1_out0;

endmodule 