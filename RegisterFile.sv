
module RegisterFile ( // in: clk, write_en, addr, data_in; out: data_out, regZero
	input                clk, write_en,
	input        [7:0] addr,
	input        [3:0] data_in,
	output       [3:0] data_out,
	output logic [3:0] reg_zero
	);

	//8 bits wide and 16 registers
	logic [3:0] registers[2**8];
	
	
	//combinational reads
	assign data_out = registers[addr];
	always_comb reg_zero = registers[0];
	
	
	//sequential (clocked) writes
	always_ff @ (posedge clk) begin
                if(write_en)
                	registers[addr] <= data_in; 
        end

endmodule 