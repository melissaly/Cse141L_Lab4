module TopLevelCpu(
        input       start,
        input       clk,
        output      halt
        );

        logic [15:0] InstCounter;

        // controls
        wire [2:0] ALUOP;
        bit        BRANCH;
        wire [1:0] PUSH_SEL;
        bit        PUSH_TOP;
        bit        PUSH_PEN;
        bit        POP_TOP;
        bit        POP_PEN;
        bit  [1:0] WRITE_REG;
        bit        WRITE_EN;
        bit        WRITE_MEM;
        bit        MEM_ADDR_SEL;
        bit        REG_ZERO;
        bit        HALT;

        // module connections
        // description_origin
        reg [7:0] reg_reg;
        reg [4:0] reg_instr;
        reg [7:0] top_stack;
        reg [7:0] pen_stack;
        reg [7:0] reg_alu;
        reg [7:0] top_alu;
        reg [7:0] pen_alu;
        bit       branch_alu;
        reg [7:0] r0_reg;
        reg [7:0] reg_mux;
        reg [7:0] top_mux;
        reg [7:0] address_mux;
        reg [7:0] address_rom;
        reg [7:0] top_mem;

        // program counter and instructions
        reg [8:0] next_instr;
        reg [8:0] jump_adr;
        reg [7:0] next_pc;
        bit temp_branch;

        always_comb begin
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
        assign temp_branch = BRANCH && branch_alu;
        end
        
        
        ProgramCounter pc(
        .clk(clk),
        .start(start),
        .abs_jump_en(temp_branch),
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
        .push_top(PUSH_TOP),
        .push_pen(PUSH_PEN),
        .pop_top(POP_TOP),
        .pop_pen(POP_PEN),
        .push_top_val(top_mux),
        .push_pen_val(pen_alu),
        .r0(next_instr[4:0]),
        .top_val(top_stack),
        .pen_val(pen_stack)
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
           
        assign halt = 0;

        always_ff@(posedge clk) begin
            if(start == 1)
                InstCounter <= 0;
            else if(halt == 0)
                InstCounter <= InstCounter + 4'h1;
        end

endmodule
