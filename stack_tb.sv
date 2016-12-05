module stack_tb;
	parameter DT = 4,
		  WT = 8;

	bit clk;
	bit push_top;
	bit push_pen;
	bit pop_pen;
	bit pop_top;
	bit [WT-1:0] pushTop;
	bit [WT-1:0] pushPen;
	
	wire [WT-1:0] topVal;
	wire [WT-1:0] penVal;

	Stack #(.W(WT), .D(DT)) uut(
	  .clk		(clk),
	  .push_top	(push_top),
	  .push_pen	(push_pen),
	  .pop_pen	(pop_pen),
          .pop_top	(pop_top),
	  .pushTop	(pushTop),
	  .pushPen	(pushPen),
	  .topVal	(topVal),
	  .penVal	(penVal)
	 );  

	initial begin
	
	  push_top = 1;
	  push_pen = 1;
	  pop_pen = 0;
	  pushTop = 8'h2;
	  pushPen = 8'h1;
	  #20ns
	
	  push_top = 1;
	  push_pen = 1;
	  pushTop = 8'h4;
	  pushPen = 8'h3;
	  #20ns


       
	
	  #20ns $stop;	

	end
always begin
  #10ns clk = 1;
  #10ns clk = 0;
end
endmodule