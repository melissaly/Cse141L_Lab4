module ProgramCounter ( // in: clk, start, abs_jump_en, halt, abs_jump, out: p_ct
    input              clk,
    input              start,
    input bit          abs_jump_en, //enables absolute jump
    input              halt,
    input        [4:0] abs_jump, // absolute jump address
    output logic [7:0] p_ct
    );

    always_ff @(posedge clk) begin
        if (halt)
            p_ct <=0;
        else if(start)
            p_ct <= 0;
        else
            case(abs_jump_en)
                1'b0:    begin 
                         p_ct <= p_ct + 8'b00000001;
                         end

                1'b1:    begin 
                         	case(abs_jump)
					5'b00000: begin
						  p_ct <= 8'b00001001;					
						  end
					5'b00001: begin
						  p_ct <= 8'b00010110;
						  end
					5'b00010: begin
						  p_ct <= 8'b00100011;
						  end
					5'b00011: begin
						  p_ct <= 8'b00001010;
						  end
					5'b00100: begin
						  p_ct <= 8'b00001110;
						  end
					5'b00101: begin
						  p_ct <= 8'b00011010;
						  end
					5'b00110: begin
						  p_ct <= 8'b00010011;
						  end
					5'b00111: begin
						  p_ct <= 8'b00100111;
						  end
					5'b01000: begin
						  p_ct <= 8'b00011110;
						  end
					5'b01001: begin
						  p_ct <= 8'b00001100;
						  end
                         	endcase
                         end

            default: ;
            endcase
    end
endmodule 
