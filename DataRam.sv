
module DataRam(data_address, write_mem, data_in, data_out, clk); // in: clk, ReadMem, write_mem, data_in; out: data_out
    input clk;
    input [7:0] data_address;
    input write_mem;
    input [7:0] data_in;
    output [7:0] data_out;

    logic [7:0] data_out;

    logic [7:0] my_memory [0:255];

    //initial 
        //$readmemh("dataram_init.list", my_memory);

    //always_comb begin
            assign data_out = my_memory[data_address];
	//		$display("Memory read M[%d] = %d",data_address,data_out);
		//end

    always @ (posedge clk)
        if(write_mem) begin
            my_memory[data_address] = data_in;
			//$display("Memory write M[%d] = %d",data_address,data_in);
        end

endmodule

