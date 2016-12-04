//This file defines the alu ops
package definitions;
/*   
// Instruction map
    	const logic [2:0] kADDL  = 'b000;
	const logic [2:0] kADDU  = 'b001;
    	const logic [2:0] kLSAL  = 'b010;
	const logic [2:0] kLSAU  = 'b011;
    	const logic [1:0] kAND  = 2'b10;
    	const logic [1:0] kXOR  = 2'b11;
*/
    typedef enum logic[2:0] {
        ADD = 3'b000, 
        BLT = 3'b001, 
        INC = 3'b010, 
        AAS = 3'b011, // and and shift
        AOV = 3'b100, // add overflow
        CON = 3'b101, //contains
        SUB = 3'b110, 
        ABS = 3'b111
    } op_mne;
    
endpackage // defintions
