
module instruction_ROM( // in: pc, out: instr
    input [3:0] InstAddress,
    output logic[8:0] InstOut);
	 
	 // Instructions have [4bit opcode][5bit rs, or rt, or immediate, or branch target]
	 
	 always_comb 
		case (InstAddress)
		// opcode = 0 set memory ptr, immediate = 1
		0 : InstOut = 9'b000000001;  // set memory pointer (r0) to hashed number and push onto stack  

		// opcode = 1 store, rs = 1, immediate = 1     
		1 : InstOut = 9'b000100001;  // store rs to where memory pointer (r0) is pointing
		// replace instruction 1 with the following to produce an infinite loop (shows branch working)
		//1 : InstOut = 10'b0001001000;  // addi reg 1 and 0
		
		// opcode = 2 push, rs = 1
		2 : InstOut = 9'b001000001;  // push rs onto the stack
		
		// opcode = 3 add, rt = 1, target = 1
        	3 : InstOut = 9'b001100001;  // add the top two values on the stack and store in reg1

		// opcode = 4 set, rt = 1
		4 : InstOut = 9'b010000001;  // set reg1 to the top values on the stack

		//opcode = 5 push immediate, immediate = 1
		5 : InstOut = 9'b010100001;  // push immediate value 1 onto stack

		//opcode = 6 pop, immediate = 1
		6 : InstOut = 9'b011000001;  // pop the immediate number of items from the stack

		//opcode = 7 blt, target = 1
		7 : InstOut = 9'b011100001;  // branch to target if top value on the stack is less than the penultimate value

		//opcode = 8 inc, rs/rt = 1
		8 : InstOut = 9'b100000001;  // increment reg1 by 1 and push it onto stack

		//opcode = 9 and and shift, rs = 1
		9 : InstOut = 9'b100100001;  // bitwise top item in the stack with ith bit(from reg1) and shifts to the right by i bits and the to the left by i bits

		//opcode = 10 add overflow, rt = 1
		10 : InstOut = 9'b101000001; // adds the top two values to the reg1 and then pops top value

		//opcode = 11 contains, target = 1
		11 : InstOut = 9'b101100001; // branch to target if the top value on the stack contains the penultimate value

		//opcode = 12 sub, rt = 1
		12 : InstOut = 9'b110000001; // sub top two values on the stack and store in reg1

		//opcode = 13 abs, rs/rt = 1
		13 : InstOut = 9'b110100001; // stores absolute value of reg1 in reg1 and pushes value onto stack
		
		// opcode = 14 halt
		//15 : InstOut = 9'b1110111111;  // halt
		default : InstOut = 9'b111111111;
    endcase

endmodule 

