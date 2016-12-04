module alu_tb;

	// DUT Input Drivers
	bit clk;
	reg [2:0] op;
	reg [7:0] reg_val;
	reg [7:0] stack0;
	reg [7:0] stack1;
	//mne op_mne; // what is this?
	// DUT Outputs
	wire [7:0] reg_out;
	wire [7:0] stack0_out;
	wire [7:0] stack1_out;
	bit branch_sig;

	// Instantiate the Unit Under Test (UUT)
	alu uut(
	  .clk(clk),
	  .op(op), 
	  .reg_val(reg_val), 
	  .stack0(stack0), 
	  .stack1(stack1), 
	  .reg_out(reg_out), 
	  .stack0_out(stack0_out), 
	  .stack1_out(stack1_out), 
	  .branch_sig(branch_sig)

	);
	//assign op_mne = mne'(RegWrite);


	initial begin

	// Wait 100 ns for global reset to finish
	  #100ns;
	// add #50ns between each test
        
	// add
	op = 3'b000;
	stack0 = 34;
	stack1 = 76;
	#50ns // wait

	// blt: branch
	op = 3'b001;
	stack0 = 30;
	stack1 = 50;
	#50ns
	// don't branch
	stack0 = 50;
	stack1 = 30;
	#50ns

	//inc
	op = 3'b010;
	reg_val = 10;
	#50ns

	// and and shift
	op = 3'b011;
	reg_val = 1;
	stack0 = 8'b11100011;
	stack1 = 8'b10101010;
	#50ns
	
	// add overflow
	stack0 = 128;
	stack1 = 128;
	op = 3'b100;
	reg_val = 10;
	#50ns

	// contains: yes
	op = 3'b101;
	stack0 = 8'b10101010;
	stack1 = 4'b1010;
	// contains: no
	#50ns
	stack1 = 4'b0000;

	// sub
	#50ns
	op = 3'b110;
	stack0 = 21;
	stack1 = 13;

	// abs
	#50ns
	op = 3'b111;
	reg_val = -5;
	#50ns
	reg_val = 5;


	end


always begin
  #10ns clk = ~clk;
end    
  
endmodule

