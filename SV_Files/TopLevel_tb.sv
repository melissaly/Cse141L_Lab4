module TopLevel_tb;
// Inputs
	bit start;
	bit clk;

// Outputs
	wire halt;
        wire out;
	// Instantiate the Unit Under Test (UUT)
	TopLevelCpu uut (
        .start(start), 
        .clk(clk), 
        .halt(halt)  
	);

	initial begin
        // Initialize Inputs
	//$readmemb("lab17.txt",IR1.ROM_core);
	//$readmemb("Reg_File_17.txt",IR1. .reg_file);
	//$readmemb("dataram_init.list",IR1. .core);
        // Wait 100 ns for global reset to finish
        #100ns;
        start = 1; 
        #10ns;
        start = 0;
        // Add stimulus here
        #550ns ;
        wait(halt) $stop;
	end

  always begin
     #5ns  clk = ~clk;
  end
      
endmodule

