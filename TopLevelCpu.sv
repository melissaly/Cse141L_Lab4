`timescale 1ns / 1ps

module TopLevelCpu(
        input       start,
        input       clk,
        output      halt
        );

        // controls
        wire [2:0] ALUOP;
        bit        BRANCH;
        wire [1:0] PUSH_SEL;
        bit        PUSH_TOP;
        bit        PUSH_PEN;
        bit        POP_TOP;
        bit        POP_PEN;
        bit        WRITE_REG;
        bit        WRITE_EN;
        bit        WRITE_MEM;
        bit	   MEM_ADDR_SEL;
        bit        REG_ZERO;
        bit        HALT;

        // module connections
        // description_origin
        wire [7:0] reg_reg;
        wire [7:0] reg_instr;
        wire [7:0] top_stack;
        wire [7:0] pen_stack;
        wire [7:0] reg_alu;
        wire [7:0] top_alu;
        wire [7:0] pen_alu;
        bit        branch_alu;
        wire [7:0] r0_reg;
        wire [7:0] reg_mux;
        wire [7:0] top_mux;
        wire [7:0] address_mux;
        wire [5:0] address_rom;
        wire [7:0] top_mem;

        // program counter and instructions
        wire [8:0] next_instr;
        wire [8:0] jump_adr;
        wire [7:0] next_pc;

	/*~ muxes ~*/
	// register address
	assign reg_instr =   (REG_ZERO) ? 5'b00000 : next_instr[4:0];

        // memory address
        assign address_mux = (MEM_ADDR_SEL) ? r0_reg : address_rom;

        // reg data
        assign reg_mux =     (WRITE_REG == 0) ? address_rom :
                             (WRITE_REG == 1) ? top_stack :
                             (WRITE_REG == 2) ? reg_alu :
                              8'bx;
        // stack data
        assign top_mux =     (PUSH_SEL == 0) ? top_mem : 
                             (PUSH_SEL == 1) ? next_instr[4:0] :
                             (PUSH_SEL == 2) ? reg_reg :
                             (PUSH_SEL == 3) ? top_alu :
                              8'bx;

        // branch and-gate
        assign BRANCH = BRANCH && branch_alu;
 
        // push if r0 and inc
        assign PUSH_TOP = (next_instr[8:5] == 8 && next_instr[4:0] == 0) ? 1 :
                           PUSH_TOP;
        
        
        ProgramCounter pc(
        .clk(clk),
        .start(start),
        .abs_jump_en(BRANCH),
        .halt(halt),
        .abs_jump(next_instr[4:0]),
        .p_ct(next_pc)
        );

        InstructionRom ir(
        .pc(next_pc),
        .instr(next_instr)
        );

        Control control_gen(
        .OPCODE(next_instr[8:5]),
        .ALUOP(ALUOP),
        .BRANCH(BRANCH),
	.PUSH_SEL(PUSH_SEL),
        .PUSH_TOP(PUSH_TOP),
        .PUSH_PEN(PUSH_PEN),
        .POP_TOP(POP_TOP),
        .POP_PEN(POP_PEN),
        .WRITE_REG(WRITE_REG),
        .WRITE_EN(WRITE_EN),
        .WRITE_MEM(WRITE_MEM),
	.MEM_ADDR_SEL(MEM_ADDR_SEL),
        .REG_ZERO(REG_ZERO),
        .HALT(HALT)
        );

        RegisterFile reg_file(
        .clk(clk),
        .write_en(WRITE_EN),
        .addr(reg_instr),
        .data_in(reg_mux),
        .data_out(reg_reg),
        .reg_zero(r0_reg)
        );

        Alu alu(
        .clk(clk),
        .op(ALUOP),
        .reg_val(reg_reg),
        .stack0(top_stack),
        .stack1(pen_stack),
        .reg_out(reg_alu),
        .stack0_out(top_alu),
        .stack1_out(pen_alu),
        .branch_sig(branch_alu)
        );

        Stack stack(
        .clk(clk),
        .push_top(top_mux),
        .push_pen(pen_alu),
        .topVal(top_stack),
        .penVal(pen_stack)
        );
        
        DataRam memory(
        .clk(clk),
        .data_address(address_mux),
        .write_mem(WRITE_MEM),
        .data_in(reg_reg),
        .data_out(top_mem)
        );

        MemoryRom rom(
        .immediate(next_instr[4:0]),
        .address(address_rom)
        );
        

endmodule
