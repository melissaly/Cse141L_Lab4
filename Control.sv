module Control(
        input        [3:0] OPCODE,
        output logic [2:0] ALUOP,
        output logic       BRANCH,
        output logic [1:0] PUSH_SEL,
        output logic       PUSH_TOP,
        output logic       PUSH_PEN,
        output logic       POP_TOP,
        output logic       POP_PEN,
        output logic [1:0] WRITE_REG,
        output logic       WRITE_EN,
        output logic       WRITE_MEM,
	output logic	   MEM_ADDR_SEL,
        output logic       REG_ZERO,
        output logic       HALT
        );

        always_comb begin
        case(OPCODE)
        0:      begin // set memory ptr
                ALUOP = 0;
                BRANCH = 0;
                PUSH_SEL = 0; // comes from memory
                PUSH_TOP = 1;
                PUSH_PEN = 0;
                POP_TOP = 0;
                POP_PEN = 0;
                WRITE_REG = 0; // comes from rom
                WRITE_EN = 1;
                WRITE_MEM = 0;
                MEM_ADDR_SEL = 0; // comes from rom
                REG_ZERO = 1;
                HALT = 0;
        end

        1:      begin // store
                ALUOP = 0;
                BRANCH = 0;
                PUSH_SEL = 0;
                PUSH_TOP = 0;
                PUSH_PEN = 0;
                POP_TOP = 0;
                POP_PEN = 0;
                WRITE_REG = 0;
                WRITE_EN = 0;
                WRITE_MEM = 1;
                MEM_ADDR_SEL = 1; // comes from r0
                REG_ZERO = 0;
                HALT = 0;
        end

        2:      begin // push
                ALUOP = 0;
                BRANCH = 0;
                PUSH_SEL = 2;
                PUSH_TOP = 1;
                PUSH_PEN = 0;
                POP_TOP = 0;
                POP_PEN = 0;
                WRITE_REG = 0;
                WRITE_EN = 0;
                WRITE_MEM = 0;
                MEM_ADDR_SEL = 1'bx;
                REG_ZERO = 0;
                HALT = 0;
        end


        3:      begin // add
                ALUOP = 0;
                BRANCH = 0;
                PUSH_SEL = 0;
                PUSH_TOP = 0;
                PUSH_PEN = 0;
                POP_TOP = 1;
                POP_PEN = 1;
                WRITE_REG = 2;
                WRITE_EN = 1;
                WRITE_MEM = 0;
                MEM_ADDR_SEL = 1'bx;
                REG_ZERO = 0;
                HALT = 0;
        end

        4:      begin // set
                ALUOP = 0;
                BRANCH = 0;
                PUSH_SEL = 0;
                PUSH_TOP = 1;
                PUSH_PEN = 0;
                POP_TOP = 0;
                POP_PEN = 0;
                WRITE_REG = 0;
                WRITE_EN = 0;
                WRITE_MEM = 0;
                MEM_ADDR_SEL = 1'bx;
                REG_ZERO = 0;
                HALT = 0;
        end

        5:      begin //push imm
                ALUOP = 0;
                BRANCH = 0;
                PUSH_SEL = 1;
                PUSH_TOP = 1;
                PUSH_PEN = 0;
                POP_TOP = 0;
                POP_PEN = 0;
                WRITE_REG = 1;
                WRITE_EN = 1;
                WRITE_MEM = 0;
                MEM_ADDR_SEL = 1'bx;
                REG_ZERO = 0;
                HALT = 0;
        end

        6:      begin // pop
                ALUOP = 0;
                BRANCH = 0;
                PUSH_SEL = 0;
                PUSH_TOP = 0;
                PUSH_PEN = 0;
                POP_TOP = 1;
                POP_PEN = 1;
                WRITE_REG = 0;
                WRITE_EN = 0;
                WRITE_MEM = 0;
                MEM_ADDR_SEL = 1'bx;
                REG_ZERO = 0;
                HALT = 0;
        end


        7:      begin // blt
                ALUOP = 1;
                BRANCH = 1;
                PUSH_SEL = 0;
                PUSH_TOP = 0;
                PUSH_PEN = 0;
                POP_TOP = 0;
                POP_PEN = 0;
                WRITE_REG = 0;
                WRITE_EN = 0;
                WRITE_MEM = 0;
                MEM_ADDR_SEL = 1'bx;
                REG_ZERO = 0;
                HALT = 0;
        end

        8:      begin // inc
                ALUOP = 2;
                BRANCH = 0;
                PUSH_SEL = 2;
                PUSH_TOP = 0;
                PUSH_PEN = 0;
                POP_TOP = 0;
                POP_PEN = 0;
                WRITE_REG = 2;
                WRITE_EN = 1;
                WRITE_MEM = 0;
                MEM_ADDR_SEL = 1'bx;
                REG_ZERO = 0;
                HALT = 0;
        end


        9:      begin // & and shift
                ALUOP = 3;
                BRANCH = 0;
                PUSH_SEL = 3;
                PUSH_TOP = 1;
                PUSH_PEN = 1;
                POP_TOP = 0;
                POP_PEN = 0;
                WRITE_REG = 0;
                WRITE_EN = 0;
                WRITE_MEM = 0;
                MEM_ADDR_SEL = 1'bx;
                REG_ZERO = 0;
                HALT = 0;
        end


        10:     begin // add overflow
                ALUOP = 4;
                BRANCH = 0;
                PUSH_SEL = 0;
                PUSH_TOP = 0;
                PUSH_PEN = 0;
                POP_TOP = 1;
                POP_PEN = 0;
                WRITE_REG = 2;
                WRITE_EN = 1;
                WRITE_MEM = 0;
                MEM_ADDR_SEL = 1'bx;
                REG_ZERO = 0;
                HALT = 0;
        end


        11:     begin // contains
                ALUOP = 5;
                BRANCH = 1;
                PUSH_SEL = 0;
                PUSH_TOP = 0;
                PUSH_PEN = 0;
                POP_TOP = 0;
                POP_PEN = 0;
                WRITE_REG = 0;
                WRITE_EN = 0;
                WRITE_MEM = 0;
                MEM_ADDR_SEL = 1'bx;
                REG_ZERO = 0;
                HALT = 0;
        end


        12:     begin // sub
                ALUOP = 6;
                BRANCH = 0;
                PUSH_SEL = 0;
                PUSH_TOP = 0;
                PUSH_PEN = 0;
                POP_TOP = 0;
                POP_PEN = 0;
                WRITE_REG = 2;
                WRITE_EN = 1;
                WRITE_MEM = 0;
                MEM_ADDR_SEL = 1'bx;
                REG_ZERO = 0;
                HALT = 0;
        end


        13:     begin // abs
                ALUOP = 7;
                BRANCH = 0;
                PUSH_SEL = 3;
                PUSH_TOP = 1;
                PUSH_PEN = 0;
                POP_TOP = 0;
                POP_PEN = 0;
                WRITE_REG = 2;
                WRITE_EN = 1;
                WRITE_MEM = 0;
                MEM_ADDR_SEL = 1'bx;
                REG_ZERO = 0;
                HALT = 0;
        end

        14:     begin // half
                ALUOP = 0;
                BRANCH = 0;
                PUSH_SEL = 0;
                PUSH_TOP = 0;
                PUSH_PEN = 0;
                POP_TOP = 0;
                POP_PEN = 0;
                WRITE_REG = 0;
                WRITE_EN = 0;
                WRITE_MEM = 0;
                MEM_ADDR_SEL = 1'bx;
                REG_ZERO = 0;
                HALT = 1;
        end

        default:begin // tbd
                ALUOP = 0;
                BRANCH = 0;
                PUSH_SEL = 0;
                PUSH_TOP = 0;
                PUSH_PEN = 0;
                POP_TOP = 0;
                POP_PEN = 0;
                WRITE_REG = 0;
                WRITE_EN = 0;
                WRITE_MEM = 0;
                MEM_ADDR_SEL = 1'bx;
                REG_ZERO = 0;
                HALT = 0;
        end


        endcase
        end
endmodule