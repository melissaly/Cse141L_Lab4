`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:13:48 05/28/2016 
// Design Name: 
// Module Name:    miniCPU 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top_level_cpu(
	input start,
	input clk,
	output halt
	);

	// controls
	wire[2:0] ALUOP;
	bit BRANCH;
	bit PUSH_TOP;
	bit PUSH_PEN;
	bit POP_TOP;
	bit POP_PEN;
	bit WRITE_REG;
	bit WRITE_EN;
	bit HALT;

	// module connections
	// description_origin
	wire[7:0] reg_reg;
	wire[7:0] top_stack;
	wire[7:0] pen_stack;
	wire[7:0] reg_alu;
	wire[7:0] top_alu;
	wire[7:0] pen_alu;
	wire[7:0] r0_reg;
	wire[7:0] reg_mux;
	wire[7:0] top_mux;
	wire[7:0] address_mux;
	wire[7:0] top_mem;

	// program counter and instructions
	wire[8:0] next_instr;
	wire[8:0] jump_adr;
	wire[8:0] next_pc;
	
	pc program_counter(
		.clk(clk),
		.start(start),
		.abs_jump_en(BRANCH),
		.halt(halt),
		.abs_jump(jump_adr),
		.p_ct(next_pc)
	);

	instruction_ROM ir(
		.InstAddress(next_pc),
		.InstOut(next_instr)
	);

	Control control_gen(
		.OPCODE(next_instr[8:5]),
		.ALUOP(ALUOP),
		.BRANCH(BRANCH),
		.PUSH_TOP(PUSH_TOP),
		.PUSH_PEN(PUSH_PEN),
		.POP_TOP(POP_TOP),
		.POP_PEN(POP_PEN),
		.WRITE_REG(WRITE_REG),
		.WRITE_EN(WRITE_EN),
		.HALT(HALT)
	);

	reg_file reg_module(
		.clk(clk),
		.write_en(WRITE_EN),
		.addr(next_instr[4:0]),
		.data_in(reg_mux),
		.data_out(reg_reg),
		.regZero(r0_reg)
	);

	alu alu_module(
		.clk(clk),
		.op(ALUOP),
		.reg_val(reg_reg),
		.stack0(top_stack),
		.stack1(pen_stack),
		.reg_out(reg_alu),
		.stack0_out(top_alu),
		.stack1_out(pen_alu),
		.branch_sig(BRANCH)
	);

	stack stack_module(
		.clk(clk),
		.push_top(top_mux),
		.push_pen(pen_alu),
		.topVal(top_stack),
		.penVal(pen_stack)
	);
	
	DataRAM memory(
		.clk(clk),
		.DataAddress(address_mux),
		.WriteMem(1'b0),
		.DataIn(reg_reg),
		.DataOut(top_mem)
	);
	

endmodule
