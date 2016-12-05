
module DataRam(DataAddress, WriteMem, DataIn, DataOut, clk); // in: clk, ReadMem, WriteMem, DataIn; out: DataOut
    input clk;
    input [7:0] DataAddress;
    input WriteMem;
    input [7:0] DataIn;
    output [7:0] DataOut;

    logic [7:0] DataOut;

    logic [7:0] my_memory [0:255];

    initial 
        //$readmemh("dataram_init.list", my_memory);

    //always_comb begin
        //if(ReadMem) begin
            DataOut = my_memory[DataAddress];
	//		$display("Memory read M[%d] = %d",DataAddress,DataOut);
       // end else 
       //     DataOut = 8'bZ;
		 //end

    always @ (posedge clk)
        if(WriteMem) begin
            my_memory[DataAddress] = DataIn;
			//$display("Memory write M[%d] = %d",DataAddress,DataIn);
        end

endmodule

