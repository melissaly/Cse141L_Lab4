
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
                         // FIX THIS
                         // FIX THIS
                         // FIX THIS
                         // FIX THIS
                         // FIX THIS
                         p_ct <= abs_jump;
                         end

                default: ;
            endcase
    end
endmodule 