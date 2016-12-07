`timescale 1ns / 1ps

module TopLevelCpu(
        input       start,
        input       clk,
        output      halt
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
        bit WRITE_MEM;

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
        wire[7:0] next_pc;
        
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
        .PUSH_TOP(PUSH_TOP),
        .PUSH_PEN(PUSH_PEN),
        .POP_TOP(POP_TOP),
        .POP_PEN(POP_PEN),
        .WRITE_REG(WRITE_REG),
        .WRITE_EN(WRITE_EN),
        .HALT(HALT),
        .WRITE_MEM(WRITE_MEM)
        );

        RegisterFile reg_file(
        .clk(clk),
        .write_en(WRITE_EN),
        .addr(next_instr[4:0]),
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
        .branch_sig(BRANCH)
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
        

endmodule
