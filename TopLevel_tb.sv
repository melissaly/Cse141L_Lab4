// Engineer:
//
// Create Date:   19:09:07 02/16/2016
// Design Name:   TopLevel
// Module Name:   /department/home/leporter/Desktop/basic_processor/TopLevel_tb.v
// Project Name:  basic_processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: TopLevel
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:

module TopLevel_tb;

// Inputs
	bit start;
	bit CLK;

// Outputs
	wire halt;

	// Instantiate the Unit Under Test (UUT)
	TopLevelCpu uut (
		.start    (start)       , 
		.CLK      (CLK)       , 
		.halt             
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
     #5ns  CLK = 1;
     #5ns  CLK = 0 ; // Toggle clock every 5 ticks
  end
      
endmodule

