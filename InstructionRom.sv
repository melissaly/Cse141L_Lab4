module InstructionRom( // in: pc, out: instr
    input        [7:0] pc,
    output logic [8:0] instr
    );

    
    logic [8:0] ROM_core[2**8]; // [8x255]

    initial

        /* read assembled machine code */
        $readmemb("lab17.txt",ROM_core);
        //$readmemb("lab18.txt",ROM_core);
        //$readmemb("lab19.txt",ROM_core);
    always_comb begin
        // retrieve instruction given address
        instr = ROM_core[pc];
        $display("");
        $display("Instruction: %b", instr);
    end

endmodule

