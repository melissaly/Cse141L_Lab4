module RegisterFile ( // in: clk, write_en, addr, data_in; out: data_out, regZero
	input        clk, write_en,
	input        [4:0] addr,
	input        [7:0] data_in,
	output       [7:0] data_out,
	output logic [7:0] reg_zero
	);

	//8 bits wide and 16 registers
	logic [7:0] registers[2**5];
	logic [7:0] temp_data_out;
        logic [7:0] temp_reg_zero;

	//sequential (clocked) writes
	always_ff @ (posedge clk) begin
  	temp_data_out = registers[addr];
	temp_reg_zero = registers[0];
        $display("Register read: [%d] = %d", addr, temp_data_out);
            if(write_en)
                registers[addr] = data_in; 
                $display("Register write: [%d] = %d", addr, data_in);
        end

        assign data_out = temp_data_out;
        assign reg_zero = temp_reg_zero;

endmodule 