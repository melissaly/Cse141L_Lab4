
module InstructionRom( // in: pc, out: instr
    input [3:0] pc,
    output logic[8:0] instr);

    logic [9:0] ROM_core[2**8]; // [9x255]

    initial

    /* read assembled machine code */
    $readmemb("machine_code",ROM_core);
	 
    always_comb

        // retrieve instruction given address
        instr = ROM_core[pc];  

    endcase

/* eldon's tests
case (inst_address)
 opcode = 0 lhw, rs = 0, rt = 1
    0 : inst_out = 10'b0000000001;  // load from address at reg 0 to reg 1  
 opcode = 1 addi, rs/rt = 1, immediate = 1
   
    1 : inst_out = 10'b0001001001;  // addi reg 1 and 1
 replace instruction 1 with the following to produce an infinite loop (shows branch working)
1 : inst_out = 10'b0001001000;  // addi reg 1 and 0
  	
 opcode = 2 shw, rs = 0, rt = 1
    2 : inst_out = 10'b0010000001;  // sw reg 1 to address in reg 0
  	
 opcode = 3 beqz, rs = 1, target = 1
    3 : inst_out = 10'b0011001001;  // beqz reg1 to absolute address 1
  	
 opcode = 15 halt
    4 : inst_out = 10'b1111111111;  // halt
    default : inst_out = 10'b0000000000;
  endcase
*/
// wtf is this idek	 
/* 
	 // Instructions have [4bit opcode][5bit rs, or rt, or immediate, or branch target]
	 $readmemh("dataram_init.list", my_memory);
	 always_comb 
		case (inst_address)
		// opcode = 0 set memory ptr, immediate = 1
		0 : inst_out = 9'b000000001;  // set memory pointer (r0) to hashed number and push onto stack  

		// opcode = 1 store, rs = 1, immediate = 1     
		1 : inst_out = 9'b000100001;  // store rs to where memory pointer (r0) is pointing
		// replace instruction 1 with the following to produce an infinite loop (shows branch working)
		//1 : inst_out = 10'b0001001000;  // addi reg 1 and 0
		
		// opcode = 2 push, rs = 1
		2 : inst_out = 9'b001000001;  // push rs onto the stack
		
		// opcode = 3 add, rt = 1, target = 1
      		3 : inst_out = 9'b001100001;  // add the top two values on the stack and store in reg1

		// opcode = 4 set, rt = 1
		4 : inst_out = 9'b010000001;  // set reg1 to the top values on the stack

		//opcode = 5 push immediate, immediate = 1
		5 : inst_out = 9'b010100001;  // push immediate value 1 onto stack

		//opcode = 6 pop, immediate = 1
		6 : inst_out = 9'b011000001;  // pop the immediate number of items from the stack

		//opcode = 7 blt, target = 1
		7 : inst_out = 9'b011100001;  // branch to target if top value on the stack is less than the penultimate value

		//opcode = 8 inc, rs/rt = 1
		8 : inst_out = 9'b100000001;  // increment reg1 by 1 and push it onto stack

		//opcode = 9 and and shift, rs = 1
		9 : inst_out = 9'b100100001;  // bitwise top item in the stack with ith bit(from reg1) and shifts to the right by i bits and the to the left by i bits

		//opcode = 10 add overflow, rt = 1
		10 : inst_out = 9'b101000001; // adds the top two values to the reg1 and then pops top value

		//opcode = 11 contains, target = 1
		11 : inst_out = 9'b101100001; // branch to target if the top value on the stack contains the penultimate value

		//opcode = 12 sub, rt = 1
		12 : inst_out = 9'b110000001; // sub top two values on the stack and store in reg1

		//opcode = 13 abs, rs/rt = 1
		13 : inst_out = 9'b110100001; // stores absolute value of reg1 in reg1 and pushes value onto stack
		
		// opcode = 14 halt
		//15 : inst_out = 9'b1110111111;  // halt
		default : inst_out = 9'b111111111;
    endcase
*/
endmodule 

