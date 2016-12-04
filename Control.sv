
module Control( //in: opcode; out: ALUOP, BRANCH, PUSH_TOP, PUSH_PEN, POP_TOP, POP_PEN, WRITE_REG, WRITE_EN, HALT
	input		[3:0]	OPCODE,
	output logic 	[2:0]	ALUOP,
	output logic		BRANCH,
	output logic		PUSH_TOP,
	output logic		PUSH_PEN,
	output logic		POP_TOP,
	output logic		POP_PEN,
	output logic		WRITE_REG,
	output logic		WRITE_EN,
	output logic		HALT
	);

	always_comb begin
	case(OPCODE)
		3:	begin
			 ALUOP = 0;
			 BRANCH = 0;
			 PUSH_TOP = 0;
			 PUSH_PEN = 0;
			 POP_TOP = 1;
			 POP_PEN = 1;
			 WRITE_REG = 1;
			 WRITE_EN = 1;
			 HALT = 0;
		end

		7:	begin
			 ALUOP = 1;
			 BRANCH = 1;
			 PUSH_TOP = 0;
			 PUSH_PEN = 0;
			 POP_TOP = 0;
			 POP_PEN = 0;
			 WRITE_REG = 0;
			 WRITE_EN = 0;
			 HALT = 0;
		end

		8:	begin
			 ALUOP = 2;
			 BRANCH = 0;
			 PUSH_TOP = 1;
			 PUSH_PEN = 0;
			 POP_TOP = 0;
			 POP_PEN = 0;
			 WRITE_REG = 1;
			 WRITE_EN = 1;
			 HALT = 0;
		end


		9:	begin
			 ALUOP = 3;
			 BRANCH = 0;
			 PUSH_TOP = 1;
			 PUSH_PEN = 1;
			 POP_TOP = 0;
			 POP_PEN = 0;
			 WRITE_REG = 0;
			 WRITE_EN = 0;
			 HALT = 0;
		end


		10:	begin
			 ALUOP = 4;
			 BRANCH = 0;
			 PUSH_TOP = 0;
			 PUSH_PEN = 0;
			 POP_TOP = 1;
			 POP_PEN = 0;
			 WRITE_REG = 1;
			 WRITE_EN = 1;
			 HALT = 0;
		end


		11:	begin
			 ALUOP = 5;
			 BRANCH = 1;
			 PUSH_TOP = 0;
			 PUSH_PEN = 0;
			 POP_TOP = 0;
			 POP_PEN = 0;
			 WRITE_REG = 0;
			 WRITE_EN = 0;
			 HALT = 0;
		end


		12:	begin
			 ALUOP = 6;
			 BRANCH = 0;
			 PUSH_TOP = 0;
			 PUSH_PEN = 0;
			 POP_TOP = 0;
			 POP_PEN = 0;
			 WRITE_REG = 1;
			 WRITE_EN = 1;
			 HALT = 0;
		end


		13:	begin
			 ALUOP = 7;
			 BRANCH = 0;
			 PUSH_TOP = 1;
			 PUSH_PEN = 0;
			 POP_TOP = 0;
			 POP_PEN = 0;
			 WRITE_REG = 1;
			 WRITE_EN = 1;
			 HALT = 0;
		end
	endcase
	end
endmodule
		