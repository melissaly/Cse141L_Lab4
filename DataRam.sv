
module DataRam( // in: clk, ReadMem, write_mem, data_in; out: data_out
    input        clk,
    input  [7:0] data_address,
    input        write_mem,
    input  [7:0] data_in,
    output [7:0] data_out
    );

    logic  [7:0] data_out_temp;
    logic  [7:0] memory [0:255];

    initial 
        $readmemh("dataram_init.list", memory);

    always_comb begin
        data_out_temp = memory[data_address];
        $display("Memory read M[%d] = %d",data_address,data_out_temp);
    end

    always @ (posedge clk)
        if(write_mem) begin
            memory[data_address] = data_in;
            $display("Memory write M[%d] = %d",data_address,data_in);
    end

    assign data_out = data_out_temp;

endmodule

