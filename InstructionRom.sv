module InstructionRom( // in: pc, out: instr
    input        [7:0] pc,
    input        [1:0] problem_number,
    output logic [8:0] instr
    );

    
    logic [8:0] ROM_core[2**8]; // [8x255]

    initial

        /* read assembled machine code */
        case (problem_number)
        2'b00:   begin
                 $readmemb("lab17",ROM_core);
                 end

        2'b01:   begin
                 $readmemb("lab18",ROM_core);
                 end

        2'b10:   begin
                 $readmemb("lab19",ROM_core);
                 end

        default: begin
                 end

        endcase

    always_comb begin
        // retrieve instruction given address
        instr = ROM_core[pc];  
    end

endmodule

