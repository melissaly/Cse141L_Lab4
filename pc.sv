
module pc ( // in: clk, start, abs_jump_en, halt, abs_jump, out: p_ct
  input	clk,
  input start,
  input abs_jump_en, //enables absolute jump
  input halt,
  input[4:0] abs_jump, // absolute jump address
  output logic[8:0] p_ct
  );

  always_ff @(posedge clk) begin
    if (halt)
	  p_ct <=0;
    else if(start)
	  p_ct <= 0;
    else
    case(abs_jump_en)
          1'b0: p_ct <= p_ct + 1;
	  1'b1: p_ct <= abs_jump;
	  default: ;
	endcase
     end
endmodule 