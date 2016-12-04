
module reg_file #(parameter W=8, D=4) ( // in: clk, write_en, addr, data_in; out: data_out, regZero
	input clk, write_en,
	input [D-1:0] addr,
	input [W-1:0] data_in,
	output [W-1:0] data_out,
	output logic [W-1:0] regZero
	);

	//8 bits wide and 16 registers
	logic [W-1:0] registers[2**D];
	
	
	//combinational reads
	assign data_out = registers[addr];
	always_comb regZero = registers[0];
	
	
	//sequential (clocked) writes
	always_ff @ (posedge clk)
		if(write_en)
			registers[addr] <= data_in; 

endmodule 