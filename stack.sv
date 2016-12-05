module Stack #(parameter W = 8, D = 5) (
	input clk, push_top, push_pen, pop_top, pop_pen,
	input [W-1:0] pushTop,
	input [W-1:0] pushPen,
	output logic [W-1:0] topVal,
	output logic [W-1:0] penVal
	);

logic [W-1:0] stacks[2**D];
int stackPtr = 0;


always_ff @ (posedge clk) begin
	if(push_pen)
	  begin
		stacks[0] <= pushPen;
		//penVal <= pushPen;
		penVal <= stacks[0];
		stackPtr <= stackPtr + 1;
		stacks[1] <= pushTop;
		topVal <= stacks[1];
		stackPtr <= stackPtr + 1;

	  end

	if(push_top && !push_pen)
	  begin
		stacks[stackPtr] <= pushTop;
		topVal <= pushTop;
		stackPtr <= stackPtr + 1;
		//topVal <= stackPtr;
	  end

	if(pop_top && pop_pen)
	  begin
		stackPtr <= stackPtr - 2;
		topVal <= stacks[1];
		stackPtr <= stackPtr - 1;
		penVal <= stacks[0];
	  end

	if(pop_top && !pop_pen)
	  begin
		stackPtr <= stackPtr - 2;
		topVal <= stacks[stackPtr];
	  end


end

endmodule
